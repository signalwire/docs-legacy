import React, { useState, useRef, useEffect } from 'react';
import clsx from 'clsx';
import { translate } from '@docusaurus/Translate';
import { useVersions, useActiveDocContext } from '@docusaurus/plugin-content-docs/client';
import { useDocsPreferredVersion } from '@docusaurus/plugin-content-docs/client';
import type { GlobalVersion } from '@docusaurus/plugin-content-docs/client';
import NavbarItem from '@theme/NavbarItem';
import { createVersionDropdownItems } from '../../utils/versionUtils';
import '../../css/version-badge.css';

type Props = {
  currentVersion: GlobalVersion;
  pluginId: string;
};

export default function VersionBadgeDropdown({ currentVersion, pluginId }: Props): JSX.Element {
  const dropdownRef = useRef<HTMLDivElement>(null);
  const [showDropdown, setShowDropdown] = useState(false);
  const versions = useVersions(pluginId);
  const { savePreferredVersionName } = useDocsPreferredVersion(pluginId);
  const activeDocContext = useActiveDocContext(pluginId);

  // Copy exact click-outside logic from DropdownNavbarItem
  useEffect(() => {
    const handleClickOutside = (
      event: MouseEvent | TouchEvent | FocusEvent,
    ) => {
      if (
        !dropdownRef.current ||
        dropdownRef.current.contains(event.target as Node)
      ) {
        return;
      }
      setShowDropdown(false);
    };

    document.addEventListener('mousedown', handleClickOutside);
    document.addEventListener('touchstart', handleClickOutside);
    document.addEventListener('focusin', handleClickOutside);

    return () => {
      document.removeEventListener('mousedown', handleClickOutside);
      document.removeEventListener('touchstart', handleClickOutside);
      document.removeEventListener('focusin', handleClickOutside);
    };
  }, [dropdownRef]);

  // Create items using shared utility
  const items = createVersionDropdownItems(
    versions,
    activeDocContext,
    currentVersion,
    savePreferredVersionName
  );

  return (
    <div
      ref={dropdownRef}
      className={clsx('dropdown', 'version-badge-dropdown-container', {
        'dropdown--show': showDropdown,
      })}>
      {/* Original Docusaurus badge as trigger */}
      <button
        className="badge badge--secondary version-badge-trigger"
        aria-haspopup="true"
        aria-expanded={showDropdown}
        onClick={() => setShowDropdown(!showDropdown)}
        onKeyDown={(e) => {
          if (e.key === 'Enter') {
            e.preventDefault();
            setShowDropdown(!showDropdown);
          }
        }}
        aria-label={translate({
          id: 'theme.docs.versionBadge.label',
          message: 'Version: {version}',
          description: 'The label for the version badge dropdown button',
        }, { version: currentVersion.label })}
      >
        <span>Version: {currentVersion.label}</span>
        <svg
          className={clsx('version-badge-dropdown-icon', showDropdown && 'version-badge-dropdown-icon-open')}
          width="12"
          height="12"
          viewBox="0 0 12 12"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
        >
          <path
            d="M3 4.5L6 7.5L9 4.5"
            stroke="currentColor"
            strokeWidth="1.5"
            strokeLinecap="round"
            strokeLinejoin="round"
          />
        </svg>
      </button>

      {/* Exact same dropdown menu structure as DropdownNavbarItem */}
      <ul className="dropdown__menu">
        {items.map((childItemProps, i) => (
          <NavbarItem
            isDropdownItem
            activeClassName="dropdown__link--active"
            {...childItemProps}
            key={i}
            onClick={() => {
              childItemProps.onClick?.();
              setShowDropdown(false);
            }}
          />
        ))}
      </ul>
    </div>
  );
}