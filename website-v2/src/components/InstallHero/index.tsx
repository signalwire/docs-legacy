import React, { ReactNode } from 'react';
import clsx from 'clsx';
import styles from './styles.module.css';
// @ts-ignore
import { FaGithub, FaBook } from 'react-icons/fa';
import { SiPypi, SiNpm } from 'react-icons/si';
import { AlphaBadge, BetaBadge } from '../AlphaBetaBadges';
import CodeBlock from '@theme/CodeBlock';
import Link from '@docusaurus/Link';

type PackageType = 'npm' | 'pypi';

interface Package {
  type: PackageType;
  packageName: string;
  githubUrl?: string;
}

interface InstallHeroProps {
  title: string;
  titleIcon?: ReactNode;
  installCommand: string;
  language?: string;
  docsUrl?: string;
  status?: 'stable' | 'beta' | 'alpha';
  packages?: Package[];
  className?: string;
  children?: ReactNode;
}

export default function InstallHero({
  title,
  titleIcon,
  installCommand,
  language = 'bash',
  docsUrl,
  status = 'stable',
  packages,
  className,
  children,
}: InstallHeroProps): JSX.Element {
  const renderStatusBadge = () => {
    if (status === 'alpha') return <AlphaBadge />;
    if (status === 'beta') return <BetaBadge />;
    return null;
  };

  const getCodeBlockWidth = () => {
    const commandLength = installCommand.length;
    if (commandLength < 30) return '400px';
    if (commandLength < 50) return '500px';
    if (commandLength < 80) return '600px';
    return '100%';
  };

  const getGitHubRepo = (url: string) => {
    return url.replace('https://github.com/', '');
  };

  const getPackageInfo = (pkg: Package) => {
    const baseInfo = (() => {
      switch (pkg.type) {
        case 'npm':
          return {
            icon: <SiNpm />,
            label: 'npm',
            href: `https://www.npmjs.com/package/${pkg.packageName}`,
            shieldUrl: `https://img.shields.io/npm/v/${pkg.packageName}?style=flat-square&color=red`,
            alt: 'npm version',
          };
        case 'pypi':
          return {
            icon: <SiPypi />,
            label: 'PyPI',
            href: `https://pypi.org/project/${pkg.packageName}/`,
            shieldUrl: `https://img.shields.io/pypi/v/${pkg.packageName}?style=flat-square&color=blue`,
            alt: 'PyPI version',
          };
        default:
          return null;
      }
    })();

    if (!baseInfo) return null;

    return {
      ...baseInfo,
      githubUrl: pkg.githubUrl,
    };
  };

  return (
    <div className={clsx(styles.installHero, className)}>
      <div className={styles.content}>
        <div className={styles.header}>
          <h1 className={styles.title}>
            {titleIcon && <span className={styles.titleIcon}>{titleIcon}</span>}
            {title}
          </h1>
          {status !== 'stable' && renderStatusBadge()}
        </div>
        
        {children && (
          <div className={styles.description}>
            {children}
          </div>
        )}

        <div className={styles.installSection}>
          <div className={styles.codeBlockWrapper} style={{ maxWidth: getCodeBlockWidth() }}>
            <CodeBlock language={language} showLineNumbers={false}>
              {installCommand}
            </CodeBlock>
          </div>
        </div>

        <div className={styles.links}>
          {packages?.map((pkg, index) => {
            const packageInfo = getPackageInfo(pkg);
            if (!packageInfo) return null;
            
            return (
              <div key={index} className={styles.packageGroup}>
                {packageInfo.githubUrl && (
                  <a 
                    href={packageInfo.githubUrl} 
                    className={styles.link} 
                    target="_blank" 
                    rel="noopener noreferrer"
                  >
                    <FaGithub /> GitHub
                    <img 
                      src={`https://img.shields.io/github/stars/${getGitHubRepo(packageInfo.githubUrl)}?style=social`}
                      alt="GitHub stars"
                      className={styles.linkShield}
                    />
                  </a>
                )}
                <a 
                  href={packageInfo.href} 
                  className={styles.link} 
                  target="_blank" 
                  rel="noopener noreferrer"
                >
                  {packageInfo.icon} {packageInfo.label}
                  <img 
                    src={packageInfo.shieldUrl}
                    alt={packageInfo.alt}
                    className={styles.linkShield}
                  />
                </a>
              </div>
            );
          })}
          {docsUrl && (
            <Link to={docsUrl} className={styles.link}>
              <FaBook /> SDK Reference
            </Link>
          )}
        </div>
      </div>
    </div>
  );
} 