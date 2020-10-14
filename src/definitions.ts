import { PluginListenerHandle } from "@capacitor/core";

declare module '@capacitor/core' {
  interface PluginRegistry {
    CustomWebView: CustomWebViewPlugin;
  }
}

export interface CustomWebViewPlugin {
  echo(options:{param : String}): Promise<{value: string}>;

  addListener(
    eventName: string,
    listenerFunc: (...args: any[]) => any,
  ): PluginListenerHandle;
}


// export interface CustomWebViewPlugin {
//   echo(value: Object ): Promise<{ value: Object }>;
// }