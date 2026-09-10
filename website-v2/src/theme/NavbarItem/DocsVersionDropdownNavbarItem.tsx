import React from 'react';
import { useActivePlugin, useAllDocsData } from '@docusaurus/plugin-content-docs/client';
import type { WrapperProps } from '@docusaurus/types';
import type DocsVersionDropdownNavbarItemType from '@theme/NavbarItem/DocsVersionDropdownNavbarItem';
import SharedVersionDropdown from '../VersionDropdown/SharedVersionDropdown';

type Props = WrapperProps<typeof DocsVersionDropdownNavbarItemType>;

export default function DocsVersionDropdownNavbarItem({
  mobile,
  docsPluginId,
  dropdownActiveClassDisabled,
  dropdownItemsBefore,
  dropdownItemsAfter,
  ...props
}: Props): React.JSX.Element | null {
  const activePlugin = useActivePlugin();
  const allDocsData = useAllDocsData();
  
  // Auto-detect mode: if no docsPluginId provided, use the active plugin
  const targetPluginId = docsPluginId || activePlugin?.pluginId;
  
  // Only show the version dropdown if we're on a docs page
  if (!activePlugin || !targetPluginId) {
    return null;
  }
  
  // Check if the target plugin has multiple versions
  const pluginData = allDocsData[targetPluginId];
  const hasMultipleVersions = pluginData && Object.keys(pluginData.versions).length > 1;
  
  // For explicit plugin ID: only show if we're on matching docs
  if (docsPluginId) {
    const isOnMatchingPluginDocs = activePlugin.pluginId === docsPluginId;
    const isPluginSpecificDropdown = docsPluginId !== 'default';
    
    if (!isOnMatchingPluginDocs || !isPluginSpecificDropdown || !hasMultipleVersions) {
      return null;
    }
  }
  // For auto-detect mode: only show if current plugin has multiple versions and isn't default
  else {
    const isNotDefaultPlugin = activePlugin.pluginId !== 'default';
    
    if (!isNotDefaultPlugin || !hasMultipleVersions) {
      return null;
    }
  }

  return (
    <SharedVersionDropdown
      pluginId={targetPluginId}
      mobile={mobile}
      position={props.position}
    />
  );
}