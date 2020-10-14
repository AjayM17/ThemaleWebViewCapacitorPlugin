import { WebPlugin } from '@capacitor/core';
import { CustomWebViewPlugin } from './definitions';

export class CustomWebViewWeb extends WebPlugin implements CustomWebViewPlugin {
  constructor() {
    super({
      name: 'CustomWebView',
      platforms: ['web'],
    });
  }

 
  async echo(options: {param : String}):Promise<{value: string}>{
    console.log(options)
    return {value:"done"}
  }

  // async echo( value: Object ): Promise<{ value: Object }> {
  //   console.log('ECHO', JSON.stringify(value));
  //   var data = [{
  //     "data":true
  //   }]
  //   return { value : data} ;
  // }
}

const CustomWebView = new CustomWebViewWeb();

export { CustomWebView };

import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(CustomWebView);
