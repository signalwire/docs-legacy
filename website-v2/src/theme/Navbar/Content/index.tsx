import React from 'react';
import OriginalNavbarContent from '@theme-original/Navbar/Content';
import type {Props} from '@theme/Navbar/Content';

export default function NavbarContent(props: Props): React.JSX.Element {
  return (
    <div style={{
      width: '100%', 
      display: 'flex',
      height: 'var(--ifm-primary-navbar-height)',
      flexShrink: 0  // Prevent flex shrinking
    }}>
      <OriginalNavbarContent {...props} />
    </div>
  );
}
