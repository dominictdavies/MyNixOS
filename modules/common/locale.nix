{
  flake.nixosModules.common = {
    time.timeZone = "Australia/Perth";
    i18n.defaultLocale = "en_AU.UTF-8";
  };
}
