import { useRef, useEffect } from "react";
import BrowserOnly from "@docusaurus/BrowserOnly";

export default function C2CWidgetInternal({
  buttonId,
  destination,
  supportsVideo,
  supportsAudio,
  token,
}: {
  buttonId: string;
  destination: string;
  supportsVideo: boolean;
  supportsAudio: boolean;
  token: string;
}) {
  const rootRef = useRef<HTMLDivElement>(null);
  const showContactFormRef = useRef<any>(null);

  useEffect(() => {
    const loadWidget = async () => {
      const module = await import("@signalwire/call-widget");
      showContactFormRef.current = module.showContactForm;
    };
    loadWidget();
  }, []);

  // react doesn't like other scripts controlling the DOM,
  // we create an empty div and inject things via js
  // note: when component unmounts, we're clearing the div
  // so react doesn't get confused and break things
  useEffect(() => {
    if (rootRef.current) {
      rootRef.current.innerHTML = "";
      const widget = document.createElement("call-widget");

      widget.setAttribute("button-id", buttonId);
      widget.setAttribute("token", token);
      widget.setAttribute("support-video", supportsVideo.toString());
      widget.setAttribute("support-audio", supportsAudio.toString());
      widget.setAttribute("destination", destination);

      const handleBeforeDial = (event: any) => {
        const approve = event.detail.approve;
        const reject = event.detail.reject;

        event.detail.hasListeners = true;

        if (!showContactFormRef.current) {
          console.error("showContactForm not loaded yet");
          reject();
          return;
        }

        showContactFormRef.current(
          {
            onSubmit: (data: any) => {
              (widget as any).newCallVariable({
                email: data.email,
                name: data.name,
                phone: data.number,
              });
              approve();
            },
            onCancel: () => {
              reject();
            },
          },
          widget,
        );
      };

      widget.addEventListener("beforeDial", handleBeforeDial);
      rootRef.current.appendChild(widget);

      return () => {
        widget.removeEventListener("beforeDial", handleBeforeDial);
      };
    }
    return () => {
      if (rootRef.current) {
        rootRef.current.innerHTML = "";
      }
    };
  }, [buttonId, destination, supportsVideo, supportsAudio]);

  return <BrowserOnly>{() => <div ref={rootRef} />}</BrowserOnly>;
}
