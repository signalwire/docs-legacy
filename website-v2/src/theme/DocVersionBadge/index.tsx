import React from 'react';
import clsx from 'clsx';
import {
  useActivePlugin,
  useVersions,
  useDocsVersion,
} from '@docusaurus/plugin-content-docs/client';
import type {Props} from '@theme/DocVersionBadge';
import type {GlobalVersion} from '@docusaurus/plugin-content-docs/client';
import VersionBadgeDropdown from '../DocVersionBanner/VersionBadgeDropdown';

export default function DocVersionBadge({
  className,
}: Props): JSX.Element | null {
  const versionMetadata = useDocsVersion();
  const {pluginId} = useActivePlugin({failfast: true})!;
  const versions = useVersions(pluginId);
  
  // Only show badge if version metadata says we should
  if (!versionMetadata.badge) {
    return null;
  }
  
  // Find the current version object
  const currentVersion = versions.find(v => v.name === versionMetadata.version);
  
  // If we have multiple versions and found the current version, show dropdown
  if (currentVersion && versions.length > 1) {
    return (
      <VersionBadgeDropdown
        currentVersion={currentVersion}
        pluginId={pluginId}
      />
    );
  }
  
  // Fallback to simple badge if only one version
  return (
    <span
      className={clsx(
        className,
        'badge badge--secondary',
      )}>
      Version: {versionMetadata.label}
    </span>
  );
}