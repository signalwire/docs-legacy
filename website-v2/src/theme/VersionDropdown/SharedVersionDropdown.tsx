import React from 'react';
import { translate } from '@docusaurus/Translate';
import { useVersions, useActiveDocContext, useDocsVersionCandidates, useDocsVersion } from '@docusaurus/plugin-content-docs/client';
import { useDocsPreferredVersion } from '@docusaurus/plugin-content-docs/client';
import DropdownNavbarItem from '@theme/NavbarItem/DropdownNavbarItem';
import { createVersionDropdownItems } from '../../utils/versionUtils';
import '../../css/version-badge.css';

type SharedVersionDropdownProps = {
  pluginId: string;
  className?: string;
  mobile?: boolean;
  position?: 'left' | 'right';
};

export default function SharedVersionDropdown({
  pluginId,
  className,
  mobile = false,
  position,
}: SharedVersionDropdownProps): React.JSX.Element {
  const versions = useVersions(pluginId);
  const activeDocContext = useActiveDocContext(pluginId);
  const { savePreferredVersionName } = useDocsPreferredVersion(pluginId);
  
  // Use Docusaurus's built-in version candidate logic
  const dropdownVersion = useDocsVersionCandidates(pluginId)[0];
  
  // Mobile dropdown is handled differently
  const dropdownLabel = mobile && versions.length > 1
    ? translate({
        id: 'theme.navbar.mobileVersionsDropdown.label',
        message: 'Versions',
        description: 'The label for the navbar versions dropdown on mobile view',
      })
    : translate({
        id: 'theme.navbar.docsVersionDropdown.label',
        message: 'Version: {versionLabel}',
        description: 'The label for the docs version dropdown',
      }, { versionLabel: dropdownVersion.label });

  // Create items using shared utility
  const items = createVersionDropdownItems(
    versions,
    activeDocContext,
    dropdownVersion,
    savePreferredVersionName
  );

  return (
    <DropdownNavbarItem
      mobile={mobile}
      label={dropdownLabel}
      items={items}
      position={position}
      className={className}
    />
  );
}