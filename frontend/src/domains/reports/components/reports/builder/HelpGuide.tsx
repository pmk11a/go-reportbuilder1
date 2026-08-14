import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/shared/ui';
import { HelpCircle } from 'lucide-react';
import React from 'react';

interface HelpGuideProps {
  title: string;
  children: React.ReactNode;
}

export function HelpGuide({ title, children }: HelpGuideProps) {
  return (
    <Dialog>
      <DialogTrigger asChild>
        <button 
          className="inline-flex items-center justify-center rounded-full w-5 h-5 text-slate-400 hover:text-indigo-500 hover:bg-indigo-50 dark:hover:bg-indigo-500/10 transition-colors ml-2 align-middle focus:outline-none" 
          title="Panduan Pengisian"
          type="button"
        >
          <HelpCircle className="w-3.5 h-3.5" />
        </button>
      </DialogTrigger>
      <DialogContent className="max-w-2xl max-h-[80vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="flex items-center gap-2">
            <HelpCircle className="w-5 h-5 text-indigo-500" />
            {title}
          </DialogTitle>
        </DialogHeader>
        <div className="text-sm text-slate-700 dark:text-slate-300 space-y-4 mt-2">
          {children}
        </div>
      </DialogContent>
    </Dialog>
  );
}
