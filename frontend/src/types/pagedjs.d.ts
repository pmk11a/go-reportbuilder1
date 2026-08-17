declare module 'pagedjs' {
  export class Previewer {
    constructor(options?: any);
    preview(content: string | Element | DocumentFragment, stylesheets?: string[], renderTo?: Element): Promise<any>;
  }
  
  export class Handler {
    constructor(chunker: any, polisher: any, caller: any);
    beforeParsed(content: Element): void;
    afterParsed(parsed: Element): void;
    beforePageLayout(page: any): void;
    afterPageLayout(pageElement: Element, page: any, breakToken: any): void;
    afterRendered(pages: any[]): void;
  }
  
  export function registerHandlers(handlers: typeof Handler): void;
}
