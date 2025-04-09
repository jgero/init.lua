{ pkgs, readAll }: {
  name = "options";
  order = 0;
  packages = [ pkgs.nodejs_22 ];
  config = readAll [ ./options.lua ./filetype.lua ./remap.lua ./spell.lua ];
}
