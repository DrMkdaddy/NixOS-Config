{
  host,
  lib,
  ...
}: {
  fileSystems =
    {
      "/".options = ["compress=zstd"];
      "/home".options = ["compress=zstd"];
    }
    // lib.optionalAttrs (host == "nasr") {"/mnt/nuclearmissilesilo".options = ["compress=zstd"];}
    // lib.optionalAttrs (host == "idris") {"/swap".options = ["noatime"];};
}
