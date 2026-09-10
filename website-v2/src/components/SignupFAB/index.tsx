import React from 'react';
import { useEffect, useState } from 'react';
import { useWindowSize } from '../../utils/hooks/useWindowSize';
import styles from './styles.module.scss';


// Import Material Web components
import '@material/web/fab/fab.js';

// TypeScript declarations for web components
declare global {
  namespace JSX {
    interface IntrinsicElements {
      'md-fab': any;
      'md-branded-fab': any;
      'md-icon': any;
    }
  }
}

const SignupFABModern: React.FC = () => {
  const windowSize = useWindowSize();

  useEffect(() => {
    console.log('Modern SignupFAB component mounted');
  }, []);

  const handleClick = () => {
    window.open('https://signalwire.com/signup', '_blank');
  };

  return (
    <md-fab
      variant="surface"
      label="Sign Up"
      aria-label="Get started with a free trial of the SignalWire platform"
      title="Get started with a free trial of the SignalWire platform"
      onClick={handleClick}
    >
    </md-fab>
  );
};

export default SignupFABModern;