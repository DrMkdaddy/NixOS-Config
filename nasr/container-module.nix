{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption types;

  secretsModule = {
    options.path = mkOption {
      type = types.path;
      example = lib.literalExample "pkgs.hello";
      description = ''
        The store path to expose to the container, accessible by the given
        <option>users</option> and <option>groups</option>.
      '';
    };
    options.users = mkOption {
      type = types.listOf types.str;
      default = [];
      description = ''
        List of users with access to the given <option>path</option>.
      '';
    };
    options.groups = mkOption {
      type = types.listOf types.str;
      default = [];
      description = ''
        List of groups with access to the given <option>path</option>.
      '';
    };
  };

  containerModule = {
    name,
    config,
    ...
  }: {
    options.secrets = mkOption {
      type = types.attrsOf (types.submodule secretsModule);
      default = {};
      example.foo = {
        path = "/some/path";
        users = ["nextcloud"];
      };
      description = ''
        A mapping between secret names and their corresponding store paths,
        which are made available to the container via a
        <literal>secrets</literal> NixOS module argument.
      '';
    };

    config = {
      bindMounts."/run/container-secrets-host" = {
        hostPath = "/run/container-secrets/${name}";
        isReadOnly = true;
      };

      config = {
        _module.args.secrets = let
          mkPath = sname: lib.const "/run/container-secrets/${sname}/path";
        in
          lib.mapAttrs mkPath config.secrets;

        systemd.services =
          lib.mapAttrs' (sname: scfg: {
            name = "secret-dir-${sname}";
            value = {
              description = "Create Directory for Secret ${sname}";

              script = let
                userPerms = map (u: "u:${u}:x") scfg.users;
                groupPerms = map (g: "g:${g}:x") scfg.groups;
                acl = lib.concatStringsSep "," (userPerms ++ groupPerms);
              in ''
                sdir=/run/container-secrets/${lib.escapeShellArg sname}
                mkdir -p "$sdir"
                ${pkgs.acl}/bin/setfacl -b -m ${lib.escapeShellArg acl} "$sdir"
              '';

              unitConfig.DefaultDependencies = false;
              serviceConfig.Type = "oneshot";
              serviceConfig.UMask = "0077";
              serviceConfig.RuntimeDirectory = "container-secrets";
              serviceConfig.RuntimeDirectoryPreserve = true;
            };
          })
          config.secrets;

        systemd.mounts =
          lib.mapAttrsToList (sname: scfg: {
            description = "Secrets for ${sname}";
            requiredBy = ["local-fs.target"];
            requires = ["secret-dir-${sname}.service"];
            before = ["local-fs.target"];
            after = ["secret-dir-${sname}.service"];

            what = "/run/container-secrets-host/${sname}";
            where = "/run/container-secrets/${sname}/path";
            type = "none";
            options = "bind,ro";
          })
          config.secrets;
      };
    };
  };
in {
  options.containers = mkOption {
    type = types.attrsOf (types.submodule containerModule);
  };

  config.systemd.services =
    lib.mapAttrs' (name: cfg: {
      name = "container@${name}";
      value = {
        confinement.enable = true;
        confinement.mode = "chroot-only";
        confinement.packages = [config.containers.${name}.path];

        serviceConfig.BindPaths =
          [
            # This is for communicating machine state back to the host via DBus.
            "/run:/run:rbind"
            # Sysfs needs to be read-write because nspawn creates cgroups.
            "/sys:/sys:rbind"
          ]
          ++ lib.mapAttrsToList (_: lib.getAttr "hostPath") cfg.bindMounts;
        serviceConfig.BindReadOnlyPaths =
          [
            "/etc/resolv.conf"
            "/etc/machine-id"
            "/etc/os-release"
            # Both of these are later mounted again in the container, so we only
            # need them for startup.
            "/dev:/dev:rbind"
            "/proc:/proc:rbind"
            # The container module tries to bind-mount these, so stub them out.
            "/dev/null:/nix/var/nix/db"
            "/dev/null:/nix/var/nix/daemon-socket"
          ]
          ++ lib.mapAttrsToList (
            sname: scfg: "${scfg.path}:/run/container-secrets/${name}/${sname}"
          )
          cfg.secrets;

        serviceConfig.PrivateTmp = true;
        serviceConfig.StateDirectory = "containers/${name}";
        serviceConfig.RuntimeDirectory = ["container-secrets/${name}"];
        serviceConfig.RuntimeDirectoryMode = "0700";
      };
    })
    config.containers;
}
