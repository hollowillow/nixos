{ pkgs, lib, config, ... }: {

	options = {
		modules.NAME.enable = lib.mkEnableOption "Enables NAME module";
	};

	config = lib.mkIf config.modules.NAME.enable {
	};

}
