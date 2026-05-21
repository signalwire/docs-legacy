import React from 'react';
import { translate } from '@docusaurus/Translate';
import type { GlobalVersion, ActiveDocContext } from '@docusaurus/plugin-content-docs/client';
import type { LinkLikeNavbarItemProps } from '@theme/NavbarItem';

/**
 * Gets the main document for a version
 */
export const getVersionMainDoc = (version: GlobalVersion) =>
  version.docs.find((doc) => doc.id === version.mainDocId)!;

/**
 * Gets the target document for a version, trying to link to the same doc
 * when possible, falling back to the main doc
 */
export const getVersionTargetDoc = (
  version: GlobalVersion, 
  activeDocContext: ActiveDocContext
) => {
  // Method 1: Use Docusaurus's built-in alternateDocVersions (preferred)
  if (activeDocContext.alternateDocVersions?.[version.name]) {
    return activeDocContext.alternateDocVersions[version.name];
  }
  
  // Method 2: Manual lookup by doc ID (fallback)
  const activeDoc = activeDocContext?.activeDoc;
  if (activeDoc) {
    const doc = version.docs.find((d) => d.id === activeDoc.id);
    if (doc) {
      return doc;
    }
  }
  
  // Method 3: Fall back to main doc
  return getVersionMainDoc(version);
};

/**
 * Creates version badges based on version status
 * Only shows "Latest" badge for the current version (version.isLast === true)
 */
export const createVersionBadges = (version: GlobalVersion) => {
  const badges = [];
  
  // Add "Latest" badge for current version
  if (version.isLast) {
    badges.push(
      <span key="latest" className="version-badge-latest">
        {translate({
          id: 'theme.versionDropdown.latestBadge',
          message: 'Latest',
          description: 'Badge for the latest version in dropdown',
        })}
      </span>
    );
  }
  
  return badges;
};

/**
 * Creates a version label with appropriate badges
 */
export const createVersionLabel = (version: GlobalVersion) => {
  const badges = createVersionBadges(version);
  
  if (badges.length === 0) {
    return version.label;
  }

  return (
    <>
      {version.label}
      {badges}
    </>
  );
};

/**
 * Creates dropdown items for versions with consistent logic
 */
export const createVersionDropdownItems = (
  versions: GlobalVersion[],
  activeDocContext: ActiveDocContext,
  currentVersion: GlobalVersion,
  savePreferredVersionName: (versionName: string) => void
): LinkLikeNavbarItemProps[] => {
  return versions.map((version) => {
    const targetDoc = getVersionTargetDoc(version, activeDocContext);
    const label = createVersionLabel(version);

    return {
      label,
      to: targetDoc.path,
      isActive: () => version === activeDocContext.activeVersion || version.name === currentVersion.name,
      onClick: () => savePreferredVersionName(version.name),
    };
  });
};