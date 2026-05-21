import React from 'react';
import { createRoot } from 'react-dom/client';
import ExecutionEnvironment from '@docusaurus/ExecutionEnvironment';
import SignupFABModern from '../components/SignupFAB';
import styles from '../components/SignupFAB/styles.module.scss';

// Only run in browser environment
if (ExecutionEnvironment.canUseDOM) {
  // Wait for DOM to be ready
  function initializeSignupFAB() {
    console.log('SignupFAB client module loaded');
    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', renderSignupFAB);
    } else {
      renderSignupFAB();
    }
  }

  function renderSignupFAB() {
    console.log('Rendering SignupFAB');
    
    // Create container for the FAB
    const fabContainer = document.createElement('div');
    fabContainer.className = styles.container;
    document.body.appendChild(fabContainer);

    console.log('FAB container created and appended');

    // Render the FAB
    const root = createRoot(fabContainer);
    root.render(<SignupFABModern />);
    
    // Add visible class after page load
    const addVisibleClass = () => {
      fabContainer.classList.add(styles.visible);
    };
    
    if (document.readyState === 'complete') {
      addVisibleClass();
    } else {
      window.addEventListener('load', addVisibleClass);
    }
    
    console.log('FAB rendered');
  }

  // Initialize when the module loads
  initializeSignupFAB();
}

export default SignupFABModern;