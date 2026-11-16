{ my, ... }:
{
  flake.nixosModules.common = {
    time.timeZone = my.timeZone;
    i18n.defaultLocale = my.locale;
  };
}
