import React from 'react';
import styles from './styles.module.css';

type APIMethod = 'GET' | 'POST' | 'PUT' | 'DELETE' | 'PATCH' | 'HEAD';

interface APIBadgeProps {
  method: APIMethod;
}

const APIBadge: React.FC<APIBadgeProps> = ({ method }) => {
  const methodClass = method.toLowerCase();
  
  return (
    <span className={`${styles.apiBadge} ${styles[methodClass]}`}>
      {method}
    </span>
  );
};

export default APIBadge;