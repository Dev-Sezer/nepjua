{
  config,
  pkgs,
  username,
  lib,
  ...
}: let
  mappingDefinitions = {
    remapCapsLockToEscape = {
      HIDKeyboardModifierMappingSrc = 30064771129;
      HIDKeyboardModifierMappingDst = 30064771113;
    };
    remapTilde = {
      HIDKeyboardModifierMappingSrc = 30064771172;
      HIDKeyboardModifierMappingDst = 30064771125;
    };
    swapLeftCommandAndLeftAlt1 = {
      HIDKeyboardModifierMappingSrc = 30064771299;
      HIDKeyboardModifierMappingDst = 30064771298;
    };
    swapLeftCommandAndLeftAlt2 = {
      HIDKeyboardModifierMappingSrc = 30064771298;
      HIDKeyboardModifierMappingDst = 30064771299;
    };
  };
  customKeyboardMappingList = [
    {
      external = true;
      name = "G815 RGB MECHANICAL GAMING KEYBOARD";
      mappingList = [
        mappingDefinitions.remapCapsLockToEscape
        mappingDefinitions.remapTilde
        mappingDefinitions.swapLeftCommandAndLeftAlt1
        mappingDefinitions.swapLeftCommandAndLeftAlt2
      ];
    }
    {
      external = false;
      mappingList = [
        mappingDefinitions.remapCapsLockToEscape
        mappingDefinitions.remapTilde
      ];
    }
  ];
  externalMappingToHidUtil = mapping: ''
    hidutil property --matching '{"Product": "${builtins.toJSON mapping.name}"' --set '{"UserKeyMapping": ${builtins.toJSON mapping.mappingList}}';
  '';
  nonExternalMappingToHidUtil = mapping: ''
    hidutil property --set '{"UserKeyMapping": ${builtins.toJSON mapping.mappingList}}';
  '';
  hidUtilCommandList = lib.forEach customKeyboardMappingList (mapping:
    if mapping.external
    then externalMappingToHidUtil mapping
    else nonExternalMappingToHidUtil mapping);
  combinedCommand = lib.concatLines hidUtilCommandList;
  # hidUtilCommand = lib.concatMapStringsSep "\n" (mapping:
  #   if mapping.external
  #   then externalMappingToHidUtil mapping
  #   else nonExternalMappingToHidUtil mapping)
  # customKeyboardMappingList;
in {
  config.debugFields = ["aaaa"];
  # system.activationScripts.labada.text = ''
  #   #!/usr/bin/env bash
  #   # Configuring keyboard
  #   echo "changeddd hid Util Command:"
  # '';
}
