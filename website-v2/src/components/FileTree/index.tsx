import { ReactNode } from "react";
import styles from "./styles.module.scss";

interface FilesProps {
  children?: ReactNode;
}

interface FolderProps {
  name: string;
  comment?: string;
  defaultOpen?: boolean;
  children?: ReactNode;
}

interface FileProps {
  name: string;
  comment?: string;
}

export function Files({ children }: FilesProps) {
  return <div className={styles.fileTree}>{children}</div>;
}

export function Folder({ name, comment, defaultOpen, children }: FolderProps) {
  return (
    <details className={styles.folder} open={defaultOpen}>
      <summary className={styles.folderSummary}>
        <span className={styles.folderIcon}>📁</span>
        <span className={styles.name}>{name}</span>
        {comment && <span className={styles.comment}>{comment}</span>}
      </summary>
      {children && <div className={styles.folderContent}>{children}</div>}
    </details>
  );
}

export function File({ name, comment }: FileProps) {
  return (
    <div className={styles.file}>
      <span className={styles.fileIcon}>📄</span>
      <span className={styles.name}>{name}</span>
      {comment && <span className={styles.comment}>{comment}</span>}
    </div>
  );
}
