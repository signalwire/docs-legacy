import { useEffect } from 'react';

export interface KeyboardShortcutOptions {
  /**
   * Whether Ctrl (Windows/Linux) or Cmd (Mac) must be pressed
   */
  ctrlCmd?: boolean;

  /**
   * Whether to prevent default browser behavior
   */
  preventDefault?: boolean;

  /**
   * Whether the callback is currently enabled
   * Useful for conditionally enabling/disabling shortcuts
   */
  enabled?: boolean;
}

/**
 * Custom hook for handling keyboard shortcuts
 *
 * @param key - The key(s) to listen for (e.g., 'Escape', 'u', ['Enter', 'Space'])
 * @param callback - Function to call when the shortcut is triggered
 * @param options - Configuration options for the shortcut
 *
 * @example
 * // Listen for Escape key
 * useKeyboardShortcut('Escape', handleClose, { enabled: isOpen });
 *
 * @example
 * // Listen for Cmd/Ctrl+U
 * useKeyboardShortcut('u', toggleModal, { ctrlCmd: true, preventDefault: true });
 *
 * Used by: ProductModal, ProductDropdownNavbarItem
 */
export function useKeyboardShortcut(
  key: string | string[],
  callback: () => void,
  options: KeyboardShortcutOptions = {}
): void {
  const {
    ctrlCmd = false,
    preventDefault = false,
    enabled = true,
  } = options;

  useEffect(() => {
    if (!enabled) return;

    const handler = (e: KeyboardEvent) => {
      const keys = Array.isArray(key) ? key : [key];
      const keyMatches = keys.some(k => e.key.toLowerCase() === k.toLowerCase());
      const modifierMatches = !ctrlCmd || (e.metaKey || e.ctrlKey);

      if (keyMatches && modifierMatches) {
        if (preventDefault) {
          e.preventDefault();
        }
        callback();
      }
    };

    document.addEventListener('keydown', handler);
    return () => document.removeEventListener('keydown', handler);
  }, [key, callback, ctrlCmd, preventDefault, enabled]);
}
