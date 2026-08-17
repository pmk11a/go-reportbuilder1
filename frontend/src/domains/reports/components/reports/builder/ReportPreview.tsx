import type { ILayoutConfig, ILayoutHeader, ILayoutBody, ILayoutFooter, ILayoutColumn } from '@/domains/reports/types';
import { Each, Show } from '@/shared/ui';
import { formatCell } from '@/domains/reports/utils/exportHelpers';
import { Fragment, useEffect, useRef } from 'react';
import { Previewer } from 'pagedjs';

interface IPaperConfig {
  size?: string;
  orientation?: 'portrait' | 'landscape';
  margin?: { top: string; right: string; bottom: string; left: string };
}

interface ReportPreviewProps {
  config: ILayoutConfig[];
  zoom?: number;
  orientation?: 'portrait' | 'landscape';
  paperConfig?: IPaperConfig;
  datasets?: Record<string, any[]>;
  mode?: 'preview' | 'print';
  isFitTable?: boolean;
}

export function ReportPreview({ 
  config, 
  zoom = 1, 
  orientation = 'portrait', 
  paperConfig, 
  datasets,
  mode = 'preview',
  isFitTable = false
}: ReportPreviewProps) {
  const targetRef = useRef<HTMLDivElement>(null);
  const contentRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    let isMounted = true;
    let timer: NodeJS.Timeout;

    timer = setTimeout(async () => {
      if (!targetRef.current || !contentRef.current || !isMounted) return;
      targetRef.current.innerHTML = '';

      // Build the CSS that Paged.js needs
      const pagedCSS = `
        .report-header-content { position: running(reportHeader); }
        .report-footer-content { position: running(reportFooter); }
        @page {
          size: ${paperConfig?.size || 'A4'} ${orientation};
          margin: 20mm 10mm 15mm 10mm;
          @top-center {
            content: element(reportHeader);
            width: 100%;
          }
          @bottom-center {
            content: element(reportFooter);
            width: 100%;
          }
        }
        .pagedjs_page {
          background: white;
          box-shadow: 0 4px 20px rgba(0,0,0,0.12);
          margin-bottom: 16px;
        }
        .pagedjs-page-number-element::after {
          content: counter(page) " dari " counter(pages);
        }
      `;

      // Create a blob URL for the CSS so Paged.js picks it up as a stylesheet
      const cssBlob = new Blob([pagedCSS], { type: 'text/css' });
      const cssUrl = URL.createObjectURL(cssBlob);

      try {
        const previewer = new Previewer();
        await previewer.preview(
          contentRef.current.innerHTML,
          [cssUrl],
          targetRef.current
        );
        URL.revokeObjectURL(cssUrl);

        if (mode === 'print') {
          setTimeout(() => window.print(), 500);
        }
      } catch (err) {
        console.error('Paged.js error:', err);
        URL.revokeObjectURL(cssUrl);
      }
    }, 200);

    return () => {
      isMounted = false;
      clearTimeout(timer);
    };
  }, [config, orientation, paperConfig, datasets, mode, isFitTable]);

  const header = config.find(c => c.type === 'header') as ILayoutHeader;
  const body = config.find(c => c.type === 'body') as ILayoutBody;
  const footer = config.find(c => c.type === 'footer') as ILayoutFooter;

  const processFormula = (formula: string, row: any) => {
    if (!formula) return '';
    let res = formula;
    const regex = /\{([^}]+)\}/g;
    res = res.replace(regex, (_match, p1) => {
      const parts = p1.split(':');
      const fieldName = parts[0];
      const formatName = parts[1];
      let val: any;

      if (fieldName.includes('.')) {
        const fieldParts = fieldName.split('.');
        const targetDsName = fieldParts[0];
        const targetField = fieldParts[1];
        const targetDs = datasets ? datasets[targetDsName] : null;

        if (targetField.startsWith('SUM(') && targetField.endsWith(')')) {
          const sumExpression = targetField.substring(4, targetField.length - 1);
          let sumFunc: (r: any) => any;
          try {
            if (/^[a-zA-Z0-9_]+$/.test(sumExpression)) {
              sumFunc = (r: any) => parseFloat(r[sumExpression]) || 0;
            } else {
              sumFunc = new Function('r', `return ${sumExpression};`) as any;
            }
          } catch (e) {
            console.error("Invalid SUM expression", sumExpression, e);
            sumFunc = () => 0;
          }
          val = targetDs ? targetDs.reduce((acc: any, r: any) => {
            try {
              const res = sumFunc(r);
              return acc + (parseFloat(res) || 0);
            } catch (e) {
              return acc;
            }
          }, 0) : 0;
        } else {
          val = targetDs && targetDs.length > 0 ? targetDs[0][targetField] : undefined;
        }
      } else {
        val = row ? row[fieldName] : undefined;
      }

      if (formatName) {
        val = formatCell(val, formatName as any);
      }
      return val !== undefined ? String(val) : '';
    });
    return res;
  };

  const renderText = (col: ILayoutColumn) => {
    let txt = col.text || '';
    if (txt) {
      txt = txt.replace('{current_date}', new Date().toLocaleDateString('id-ID'));
      txt = txt.replace('{current_time}', new Date().toLocaleTimeString('id-ID'));
      txt = txt.replace('{user_name}', 'Superadmin');
    }
    
    if (txt && txt.includes('{') && txt.includes('}')) {
      const regex = /\{([^}]+)\}/g;
      txt = txt.replace(regex, (match, p1) => {
        if (p1 === 'current_date' || p1 === 'current_time' || p1 === 'user_name') return match;
        const parts = p1.split('.');
        if (parts.length >= 2) {
          const datasetName = parts[0];
          const fieldName = parts[1];
          const targetDs = datasets ? datasets[datasetName] : null;
          if (targetDs && targetDs.length > 0) {
            return String(targetDs[0][fieldName] || '');
          }
        }
        return match;
      });
    }

    if (col.sourceType === 'database') return <span className="text-blue-600 font-mono bg-blue-50 px-1 rounded py-0.5 text-xs">[{col.dataset || '?'}.{col.field || '?'}]</span> as unknown as string;
    if (col.sourceType === 'filter') return <span className="text-emerald-600 font-mono bg-emerald-50 px-1 rounded py-0.5 text-xs">[Filter: {col.filter || '?'}]</span> as unknown as string;
    
    return txt;
  };

  const renderSignatureText = (text?: string) => {
    if (!text) return null;
    if (text.startsWith('{') && text.endsWith('}')) {
      return <span className="text-blue-600 font-mono bg-blue-50 px-1 rounded text-xs">{text}</span>;
    }
    
    // Prevent Paged.js from crashing on extremely long unbroken strings.
    // Truncate ANY character repeated more than 30 times consecutively.
    let processedText = text;
    processedText = processedText.replace(/(.)\1{29,}/g, (_match, char) => char.repeat(30));
    
    return processedText;
  };

  const width = paperConfig?.orientation === 'landscape' || orientation === 'landscape' ? 297 : 210;
  const height = paperConfig?.orientation === 'landscape' || orientation === 'landscape' ? 210 : 297;


  const rawContent = (
    <div className="report-raw-content" style={{ fontFamily: 'inherit', fontSize: 'inherit', color: '#1f2937' }}>
      <style>
        {`
            .report-table-wrapper table {
              table-layout: ${isFitTable ? 'fixed' : 'auto'};
              width: ${mode === 'print' ? '100%' : (isFitTable ? '100%' : 'max-content')};
              max-width: ${mode === 'print' ? '100%' : (isFitTable ? '100%' : 'none')};
            }
            .report-table-wrapper {
              overflow-x: ${mode === 'print' ? 'hidden' : (isFitTable ? 'hidden' : 'auto')};
              width: 100%;
              max-width: 100%;
            }
            .report-table-wrapper td, .report-table-wrapper th {
              word-wrap: break-word;
              white-space: normal;
            }
            .report-table-wrapper::-webkit-scrollbar {
              height: 10px;
            }
            .report-table-wrapper::-webkit-scrollbar-track {
              background: #f1f5f9;
              border-radius: 4px;
            }
            .report-table-wrapper::-webkit-scrollbar-thumb {
              background: #cbd5e1;
              border-radius: 4px;
            }
            .report-table-wrapper::-webkit-scrollbar-thumb:hover {
              background: #94a3b8;
            }
            @media print {
              .report-table-wrapper table {
                width: 100% !important;
                table-layout: fixed !important;
              }
            }
            /* Add gap at bottom of each page so content doesn't touch footer directly */
            .pagedjs_page_content {
               padding-bottom: 20px;
            }
          `}
        </style>
        
        <div className="w-full">
          <div className="report-header-content pb-4">
                <Show when={!!(header && header.rows && header.rows.length > 0)}>
                  <div className="w-full">
                    <table className="w-full text-sm border-b-2 border-black">
                      <tbody>
                        <Each of={header?.rows || []}>
                          {(row, rIdx) => (
                            <tr key={rIdx}>
                              <Each of={row.columns || []}>
                                {(col, cIdx) => (
                                  <td 
                                    key={cIdx} 
                                    colSpan={col.colSpan || 1} 
                                    className="py-1"
                                    style={{ textAlign: col.align || 'left', width: col.width }}
                                    dangerouslySetInnerHTML={{ __html: renderText(col) }}
                                  />
                                )}
                              </Each>
                            </tr>
                          )}
                        </Each>
                      </tbody>
                    </table>
                  </div>
                </Show>
          </div>

          {/* Running footer - placed early so Paged.js activates it from page 1 */}
          <div className="report-footer-content">
            <div className="pt-2 border-t border-slate-300 w-full flex justify-between text-[10px] text-gray-500 font-mono">
              <div>Dicetak oleh: Superadmin pada {new Date().toLocaleString('id-ID')}</div>
              <div>Halaman <span className="pagedjs-page-number-element"></span></div>
            </div>
          </div>
          
          <div className="report-body-content py-2">
                <Show when={!!(body && body.rows && body.rows.length > 0)}>
                  <div className="w-full">
                    <Each of={body?.rows || []}>
                      {(row, rIdx) => (
                        <div key={rIdx} className="w-full">
                          {row.type === 'signature' && row.signatureRow ? (
                            <div className="w-full px-2 mt-8 mb-4" style={{ textAlign: 'center' }}>
                              <Each of={row.signatureRow.columns || []}>
                                {(col, cIdx) => (
                                  <div 
                                    key={cIdx} 
                                    style={{ 
                                      display: 'inline-block', 
                                      width: `${100 / (row.signatureRow?.columns?.length || 1)}%`,
                                      verticalAlign: 'top',
                                      wordBreak: 'break-all',
                                      overflowWrap: 'anywhere'
                                    }}
                                    className={`text-sm text-center px-2 ${row.signatureRow?.showBorder ? 'border border-black p-2' : ''}`}
                                  >
                                    <div className="block w-full">
                                      <Show when={!!col.title}>
                                        <div className="mb-1">{renderSignatureText(col.title)}</div>
                                      </Show>
                                      <Show when={!!col.title2}>
                                        <div className="mb-1">{renderSignatureText(col.title2)}</div>
                                      </Show>
                                      
                                      <div className="h-20" />
                                      
                                      <Show when={!!col.name}>
                                        <div className="font-bold text-gray-800 underline underline-offset-4">{renderSignatureText(col.name)}</div>
                                      </Show>
                                      <Show when={!!col.role}>
                                        <div className="text-xs text-gray-800 mt-1">{renderSignatureText(col.role)}</div>
                                      </Show>
                                      <Show when={!!col.role2}>
                                        <div className="text-xs text-gray-500">{renderSignatureText(col.role2)}</div>
                                      </Show>
                                    </div>
                                  </div>
                                )}
                              </Each>
                            </div>
                          ) : (row.columns && row.columns.length > 1) ? (
                            /* Multiple columns side-by-side: use CSS float for Paged.js compatibility.
                               CRITICAL for Paged.js: We MUST render the columns in REVERSE order in the DOM.
                               If a long table (Left) is rendered first, it paginates and the short table (Right) 
                               gets pushed to the last page. By rendering Right first (with float: right), 
                               it anchors to Page 1, and Left (float: left) flows around it and paginates normally. */
                            <div style={{ width: '100%', overflow: 'hidden' }}>
                              <Each of={[...(row.columns || [])].reverse()}>
                                {(col, revIdx) => {
                                  // Since we reversed the array, the ORIGINAL first column is now the LAST in this array.
                                  const isFirstOriginal = revIdx === (row.columns?.length || 1) - 1;
                                  
                                  return (
                                    <div 
                                      key={revIdx}
                                      style={{ 
                                        float: isFirstOriginal ? 'left' : 'right',
                                        width: col.width || `${100 / (row.columns?.length || 1)}%`,
                                        boxSizing: 'border-box',
                                        padding: '0 8px',
                                        marginTop: col.marginTop || '0px'
                                      }}
                                    >
                                      <div className="w-full report-table-wrapper mt-2">
                                        <Show when={!!col.table?.title}>
                                          <h4 className="font-bold text-sm mb-2">{col.table?.title}</h4>
                                        </Show>
                                        <table 
                                          className={`w-full text-[10px] border-collapse ${col.table?.showBorder !== false ? 'border border-gray-300' : ''}`}
                                          style={{ 
                                            ...(col.table?.tableLayout ? { tableLayout: col.table.tableLayout as any } : {}),
                                            wordBreak: 'break-word'
                                          }}
                                        >
                                          <thead className="bg-gray-100 ">
                                            <Each of={col.table?.headerRows || []}>
                                              {(hRow, hrIdx) => (
                                                <tr key={hrIdx}>
                                                  <Each of={hRow || []}>
                                                    {(hCol, hcIdx) => (
                                                      <th 
                                                        key={hcIdx} 
                                                        rowSpan={hCol.rowSpan || 1} 
                                                        colSpan={hCol.colSpan || 1}
                                                        className="border border-gray-300 p-2 font-semibold whitespace-normal break-words"
                                                        style={{ textAlign: hCol.align || 'center', width: hCol.width }}
                                                      >
                                                        {hCol.text && hCol.text.includes('{') ? processFormula(hCol.text, {}) : hCol.text}
                                                      </th>
                                                    )}
                                                  </Each>
                                                </tr>
                                              )}
                                            </Each>
                                          </thead>
                                          <tbody>
                                            {(() => {
                                              if (!col.table?.dataColumns || col.table.dataColumns.length === 0) return null;
                                              
                                              const dsName = col.table.dataset;
                                              let realData = datasets ? (dsName ? (datasets[dsName] || []) : [{}]) : null;

                                              if (realData && realData.length > 0) {
                                                const groupByRaw = col.table.grouping?.groupBy;
                                                const groupByFields = groupByRaw ? groupByRaw.split(',').map(s => s.trim()).filter(Boolean) : [];
                                                let groupedRows: { key: string; rows: any[] }[] = [];
                                                if (groupByFields.length > 0) {
                                                  const groupsMap = new Map<string, any[]>();
                                                  for (const r of realData) {
                                                    const key = groupByFields.map(f => String(r[f] || '')).join(' | ');
                                                    if (!groupsMap.has(key)) groupsMap.set(key, []);
                                                    groupsMap.get(key)!.push(r);
                                                  }
                                                  groupedRows = Array.from(groupsMap.entries()).map(([key, rows]) => ({ key, rows }));
                                                } else {
                                                  groupedRows = [{ key: '', rows: realData }];
                                                }

                                                const showGrandTotal = col.table.showGrandTotal !== false;
                                                const hideSubtotalIfSingleGroup = col.table.grouping?.hideSubtotalIfSingleGroup === true;
                                                const isSingleGroup = groupedRows.length === 1;
                                                const showSubtotalForGroups = col.table.grouping?.showSubtotal && !(isSingleGroup && showGrandTotal && hideSubtotalIfSingleGroup);
                                                const firstSumColIdx = (col.table.dataColumns || []).findIndex(dCol => col.table?.grouping?.subtotalColumns?.includes(dCol.field));
                                                const labelColspan = firstSumColIdx > 0 ? firstSumColIdx : 1;

                                                return (
                                                  <>
                                                    <Each of={groupedRows}>
                                                      {(group, gIdx) => (
                                                        <Fragment key={gIdx}>
                                                          {groupByFields.length > 0 && (
                                                            <tr className="bg-slate-50 text-slate-700 ">
                                                              <td colSpan={col.table?.dataColumns?.length || 1} className="border border-gray-300 p-2 text-left text-[10px] font-bold bg-gray-50 whitespace-normal break-words">
                                                                [Group: {group.key}]
                                                              </td>
                                                            </tr>
                                                          )}
                                                          <Each of={col.table?.grouping?.showOnlyFirstRowPerGroup ? [group.rows[0]] : group.rows}>
                                                            {(r, rowIdx) => (
                                                              <tr key={rowIdx} className=" hover:bg-slate-50/50">
                                                                <Each of={col.table?.dataColumns || []}>
                                                                  {(dCol, dCIdx) => {
                                                                    let cellValue = r[dCol.field];
                                                                    if (dCol.type === 'row_number') {
                                                                      cellValue = rowIdx + 1;
                                                                    } else if (dCol.type === 'formula' && dCol.formula) {
                                                                      cellValue = processFormula(dCol.formula, r);
                                                                    } else {
                                                                      cellValue = formatCell(cellValue, dCol.format as any);
                                                                    }
                                                                    if (dCol.isHeader) {
                                                                      return (
                                                                        <th key={dCIdx} className="border border-gray-300 p-2 font-bold bg-gray-100 text-gray-800 whitespace-normal break-words" style={{ textAlign: dCol.align || 'center', width: dCol.width }}>
                                                                          {cellValue}
                                                                        </th>
                                                                      );
                                                                    }
                                                                    return (
                                                                      <td key={dCIdx} className="border border-gray-300 p-2 whitespace-normal break-words" style={{ textAlign: dCol.align || 'left', width: dCol.width }}>
                                                                        {cellValue}
                                                                      </td>
                                                                    );
                                                                  }}
                                                                </Each>
                                                              </tr>
                                                            )}
                                                          </Each>
                                                          {showSubtotalForGroups && (
                                                            <tr className="bg-slate-100 font-bold text-slate-800 ">
                                                              <Each of={col.table?.dataColumns || []}>
                                                                {(dCol, dCIdx) => {
                                                                  if (dCIdx > 0 && dCIdx < firstSumColIdx) return null;
                                                                  const isSummed = col.table?.grouping?.subtotalColumns?.includes(dCol.field);
                                                                  const isLabelCell = dCIdx === 0;
                                                                  const formatToUse = (dCol.format === 'currency' || dCol.format === 'number') ? dCol.format : 'number';
                                                                  return (
                                                                    <td key={`sub-${dCIdx}`} className="border border-gray-300 p-2 bg-gray-100 text-[10px] whitespace-normal break-words" colSpan={isLabelCell ? labelColspan : 1} style={{ textAlign: isSummed ? 'right' : (isLabelCell && labelColspan > 1 ? 'right' : dCol.align || 'left') }}>
                                                                      {isSummed ? (datasets === undefined ? "999,999" : formatCell(group.rows.reduce((acc: number, rowVal: any) => acc + (parseFloat(rowVal[dCol.field]) || 0), 0), formatToUse as any)) : (isLabelCell ? (col.table?.grouping?.subtotalLabel || 'Sub Total') : "")}
                                                                    </td>
                                                                  );
                                                                }}
                                                              </Each>
                                                            </tr>
                                                          )}
                                                        </Fragment>
                                                      )}
                                                    </Each>
                                                    {showGrandTotal && (!isSingleGroup || (isSingleGroup && hideSubtotalIfSingleGroup)) && col.table?.grouping?.showSubtotal && (
                                                      <tr className="bg-slate-200 font-bold text-slate-900 border-t-2 border-slate-400 ">
                                                        <Each of={col.table?.dataColumns || []}>
                                                          {(dCol, dCIdx) => {
                                                            if (dCIdx > 0 && dCIdx < firstSumColIdx) return null;
                                                            const isSummed = col.table?.grouping?.subtotalColumns?.includes(dCol.field);
                                                            const isLabelCell = dCIdx === 0;
                                                            const formatToUse = (dCol.format === 'currency' || dCol.format === 'number') ? dCol.format : 'number';
                                                            return (
                                                              <td key={`grand-${dCIdx}`} className="border border-gray-300 p-2 text-[10px] whitespace-normal break-words" colSpan={isLabelCell ? labelColspan : 1} style={{ textAlign: isSummed ? 'right' : (isLabelCell && labelColspan > 1 ? 'right' : dCol.align || 'left') }}>
                                                                {isSummed ? (datasets === undefined ? "9,999,999" : formatCell(realData.reduce((acc: number, rowVal: any) => acc + (parseFloat(rowVal[dCol.field]) || 0), 0), formatToUse as any)) : (isLabelCell ? "Grand Total" : "")}
                                                              </td>
                                                            );
                                                          }}
                                                        </Each>
                                                      </tr>
                                                    )}
                                                  </>
                                                );
                                              }

                                              if (datasets !== undefined) {
                                                return (
                                                  <tr>
                                                    <td colSpan={col.table?.dataColumns?.length || 1} className="border border-gray-300 p-4 text-center text-slate-500 italic">
                                                      Tidak ada data
                                                    </td>
                                                  </tr>
                                                );
                                              }

                                              return (
                                                <>
                                                  {col.table?.grouping?.groupBy ? (
                                                    <>
                                                      <tr className="bg-slate-50 text-slate-700">
                                                        <td colSpan={col.table?.dataColumns?.length || 1} className="border border-gray-300 p-2 text-left text-xs font-bold bg-gray-50 whitespace-normal break-words">
                                                          [Group: {col.table.grouping.groupBy}]
                                                        </td>
                                                      </tr>
                                                      <Each of={[1, 2]}>
                                                        {(_, rowIdx) => (
                                                          <tr key={rowIdx}>
                                                            <Each of={col.table?.dataColumns || []} fallback={
                                                              <td className="border border-gray-300 p-2"><div className="h-3 bg-gray-200 rounded animate-pulse w-3/4 mx-auto" /></td>
                                                            }>
                                                              {(dCol, dCIdx) => (
                                                                <td key={dCIdx} className="border border-gray-300 p-2 whitespace-normal break-words" style={{ textAlign: dCol.align || 'left' }}>
                                                                  <div className="h-3 bg-gray-200 rounded animate-pulse w-3/4 mx-auto" />
                                                                </td>
                                                              )}
                                                            </Each>
                                                          </tr>
                                                        )}
                                                      </Each>
                                                    </>
                                                  ) : (
                                                    <Each of={[1, 2, 3, 4, 5]}>
                                                      {(_, rowIdx) => (
                                                        <tr key={rowIdx}>
                                                          <Each of={col.table?.dataColumns || []} fallback={
                                                            <td className="border border-gray-300 p-2"><div className="h-3 bg-gray-200 rounded animate-pulse w-3/4 mx-auto" /></td>
                                                          }>
                                                            {(dCol, dCIdx) => (
                                                              <td key={dCIdx} className="border border-gray-300 p-2 whitespace-normal break-words" style={{ textAlign: dCol.align || 'left' }}>
                                                                <div className="h-3 bg-gray-200 rounded animate-pulse w-3/4 mx-auto" />
                                                              </td>
                                                            )}
                                                          </Each>
                                                        </tr>
                                                      )}
                                                    </Each>
                                                  )}
                                                </>
                                              );
                                            })()}
                                          </tbody>
                                        </table>
                                      </div>
                                    </div>
                                  );
                                }}
                              </Each>
                              <div style={{ clear: 'both' as const }} />
                            </div>
                          ) : (
                            /* Single column: render directly without layout table */
                            <Each of={row.columns || []}>
                              {(col, cIdx) => {
                                let alignClass = '';
                                if (col.align === 'center') alignClass = 'mx-auto';
                                else if (col.align === 'right') alignClass = 'ml-auto';
                                else if (col.align === 'left') alignClass = 'mr-auto';

                                return (
                                  <div 
                                    key={cIdx} 
                                    className={`${alignClass} ${col.colSpan ? `col-span-${col.colSpan}` : ''} box-border px-2`} 
                                    style={{ 
                                      width: col.width || '100%',
                                      marginTop: col.marginTop || '0px'
                                    }}
                                  >
                                    <div className="w-full  report-table-wrapper mt-2">
                                      <Show when={!!col.table?.title}>
                                        <h4 className="font-bold text-sm mb-2">{col.table?.title}</h4>
                                      </Show>
                                      <table 
                                        className={`w-full text-[10px] border-collapse ${col.table?.showBorder !== false ? 'border border-gray-300' : ''}`}
                                        style={{ 
                                          ...(col.table?.tableLayout ? { tableLayout: col.table.tableLayout as any } : {}),
                                          wordBreak: 'break-word'
                                        }}
                                      >
                                        <thead className="bg-gray-100 ">
                                          <Each of={col.table?.headerRows || []}>
                                            {(hRow, hrIdx) => (
                                              <tr key={hrIdx}>
                                                <Each of={hRow || []}>
                                                  {(hCol, hcIdx) => (
                                                    <th 
                                                      key={hcIdx} 
                                                      rowSpan={hCol.rowSpan || 1} 
                                                      colSpan={hCol.colSpan || 1}
                                                      className="border border-gray-300 p-2 font-semibold"
                                                      style={{ textAlign: hCol.align || 'center', width: hCol.width }}
                                                    >
                                                      {hCol.text && hCol.text.includes('{') ? processFormula(hCol.text, {}) : hCol.text}
                                                    </th>
                                                  )}
                                                </Each>
                                              </tr>
                                            )}
                                          </Each>
                                        </thead>
                                        <tbody>
                                          {(() => {
                                            if (!col.table?.dataColumns || col.table.dataColumns.length === 0) return null;
                                            
                                            const dsName = col.table.dataset;
                                            let realData = datasets ? (dsName ? (datasets[dsName] || []) : [{}]) : null;

                                            if (realData && realData.length > 0) {
                                              // 1. Group Data
                                              const groupByRaw = col.table.grouping?.groupBy;
                                              const groupByFields = groupByRaw ? groupByRaw.split(',').map(s => s.trim()).filter(Boolean) : [];
                                              let groupedRows: { key: string; rows: any[] }[] = [];
                                              if (groupByFields.length > 0) {
                                                const groupsMap = new Map<string, any[]>();
                                                for (const r of realData) {
                                                  const key = groupByFields.map(f => String(r[f] || '')).join(' | ');
                                                  if (!groupsMap.has(key)) groupsMap.set(key, []);
                                                  groupsMap.get(key)!.push(r);
                                                }
                                                groupedRows = Array.from(groupsMap.entries()).map(([key, rows]) => ({ key, rows }));
                                              } else {
                                                groupedRows = [{ key: '', rows: realData }];
                                              }

                                              const showGrandTotal = col.table.showGrandTotal !== false;
                                              const hideSubtotalIfSingleGroup = col.table.grouping?.hideSubtotalIfSingleGroup === true;
                                              const isSingleGroup = groupedRows.length === 1;

                                              // Subtotal visibility check
                                              const showSubtotalForGroups = col.table.grouping?.showSubtotal && !(isSingleGroup && showGrandTotal && hideSubtotalIfSingleGroup);

                                              const firstSumColIdx = (col.table.dataColumns || []).findIndex(dCol => col.table?.grouping?.subtotalColumns?.includes(dCol.field));
                                              const labelColspan = firstSumColIdx > 0 ? firstSumColIdx : 1;

                                              return (
                                                <>
                                                  <Each of={groupedRows}>
                                                    {(group, gIdx) => (
                                                      <Fragment key={gIdx}>
                                                        {/* Group Header */}
                                                        {groupByFields.length > 0 && (
                                                          <tr className="bg-slate-50 text-slate-700 ">
                                                            <td colSpan={col.table?.dataColumns?.length || 1} className="border border-gray-300 p-2 text-left text-[10px] font-bold bg-gray-50">
                                                              [Group: {group.key}]
                                                            </td>
                                                          </tr>
                                                        )}

                                                        {/* Group Rows */}
                                                        <Each of={col.table?.grouping?.showOnlyFirstRowPerGroup ? [group.rows[0]] : group.rows}>
                                                          {(r, rowIdx) => (
                                                            <tr key={rowIdx} className=" hover:bg-slate-50/50">
                                                              <Each of={col.table?.dataColumns || []}>
                                                                {(dCol, dCIdx) => {
                                                                  let cellValue = r[dCol.field];
                                                                  if (dCol.type === 'row_number') {
                                                                    cellValue = rowIdx + 1;
                                                                  } else if (dCol.type === 'formula' && dCol.formula) {
                                                                    cellValue = processFormula(dCol.formula, r);
                                                                  } else {
                                                                    cellValue = formatCell(cellValue, dCol.format as any);
                                                                  }
                                                                  if (dCol.isHeader) {
                                                                    return (
                                                                      <th 
                                                                        key={dCIdx} 
                                                                        className="border border-gray-300 p-2 font-bold bg-gray-100 text-gray-800"
                                                                        style={{ textAlign: dCol.align || 'center', width: dCol.width }}
                                                                      >
                                                                        {cellValue}
                                                                      </th>
                                                                    );
                                                                  }
                                                                  return (
                                                                    <td 
                                                                      key={dCIdx} 
                                                                      className="border border-gray-300 p-2"
                                                                      style={{ textAlign: dCol.align || 'left', width: dCol.width }}
                                                                    >
                                                                      {cellValue}
                                                                    </td>
                                                                  );
                                                                }}
                                                              </Each>
                                                            </tr>
                                                          )}
                                                        </Each>

                                                        {/* Group Subtotal */}
                                                        {showSubtotalForGroups && (
                                                          <tr className="bg-slate-100 font-bold text-slate-800 ">
                                                            <Each of={col.table?.dataColumns || []}>
                                                              {(dCol, dCIdx) => {
                                                                if (dCIdx > 0 && dCIdx < firstSumColIdx) return null;
                                                                const isSummed = col.table?.grouping?.subtotalColumns?.includes(dCol.field);
                                                                const isLabelCell = dCIdx === 0;
                                                                const formatToUse = (dCol.format === 'currency' || dCol.format === 'number') ? dCol.format : 'number';
                                                                return (
                                                                  <td 
                                                                    key={`sub-${dCIdx}`} 
                                                                    className="border border-gray-300 p-2 bg-gray-100 text-[10px]"
                                                                    colSpan={isLabelCell ? labelColspan : 1}
                                                                    style={{ textAlign: isSummed ? 'right' : (isLabelCell && labelColspan > 1 ? 'right' : dCol.align || 'left') }}
                                                                  >
                                                                    {isSummed ? (datasets === undefined ? "999,999" : formatCell(group.rows.reduce((acc: number, rowVal: any) => acc + (parseFloat(rowVal[dCol.field]) || 0), 0), formatToUse as any)) : (isLabelCell ? (col.table?.grouping?.subtotalLabel || 'Sub Total') : "")}
                                                                  </td>
                                                                );
                                                              }}
                                                            </Each>
                                                          </tr>
                                                        )}
                                                      </Fragment>
                                                    )}
                                                  </Each>

                                                  {/* Grand Total */}
                                                  {showGrandTotal && (!isSingleGroup || (isSingleGroup && hideSubtotalIfSingleGroup)) && col.table?.grouping?.showSubtotal && (
                                                    <tr className="bg-slate-200 font-bold text-slate-900 border-t-2 border-slate-400 ">
                                                      <Each of={col.table?.dataColumns || []}>
                                                        {(dCol, dCIdx) => {
                                                          if (dCIdx > 0 && dCIdx < firstSumColIdx) return null;
                                                          const isSummed = col.table?.grouping?.subtotalColumns?.includes(dCol.field);
                                                          const isLabelCell = dCIdx === 0;
                                                          const formatToUse = (dCol.format === 'currency' || dCol.format === 'number') ? dCol.format : 'number';
                                                          return (
                                                            <td 
                                                              key={`grand-${dCIdx}`} 
                                                              className="border border-gray-300 p-2 text-[10px]"
                                                              colSpan={isLabelCell ? labelColspan : 1}
                                                              style={{ textAlign: isSummed ? 'right' : (isLabelCell && labelColspan > 1 ? 'right' : dCol.align || 'left') }}
                                                            >
                                                              {isSummed ? (datasets === undefined ? "9,999,999" : formatCell(realData.reduce((acc: number, rowVal: any) => acc + (parseFloat(rowVal[dCol.field]) || 0), 0), formatToUse as any)) : (isLabelCell ? "Grand Total" : "")}
                                                            </td>
                                                          );
                                                        }}
                                                      </Each>
                                                    </tr>
                                                  )}
                                                </>
                                              );
                                            }

                                            // If datasets is provided but empty
                                            if (datasets !== undefined) {
                                              return (
                                                <tr>
                                                  <td colSpan={col.table?.dataColumns?.length || 1} className="border border-gray-300 p-4 text-center text-slate-500 italic">
                                                    Tidak ada data
                                                  </td>
                                                </tr>
                                              );
                                            }

                                            // Fallback Shimmer
                                            return (
                                              <>
                                                {col.table?.grouping?.groupBy ? (
                                                  <>
                                                    <tr className="bg-slate-50 text-slate-700">
                                                      <td colSpan={col.table?.dataColumns?.length || 1} className="border border-gray-300 p-2 text-left text-xs font-bold bg-gray-50">
                                                        [Group: {col.table.grouping.groupBy}]
                                                      </td>
                                                    </tr>
                                                    <Each of={[1, 2]}>
                                                      {(_, rowIdx) => (
                                                        <tr key={rowIdx}>
                                                          <Each of={col.table?.dataColumns || []} fallback={
                                                            <td className="border border-gray-300 p-2">
                                                              <div className="h-3 bg-gray-200 rounded animate-pulse w-3/4 mx-auto" />
                                                            </td>
                                                          }>
                                                            {(dCol, dCIdx) => (
                                                              <td key={dCIdx} className="border border-gray-300 p-2" style={{ textAlign: dCol.align || 'left' }}>
                                                                <div className="h-3 bg-gray-200 rounded animate-pulse w-3/4 mx-auto" />
                                                              </td>
                                                            )}
                                                          </Each>
                                                        </tr>
                                                      )}
                                                    </Each>
                                                  </>
                                                ) : (
                                                  <Each of={[1, 2, 3, 4, 5]}>
                                                    {(_, rowIdx) => (
                                                      <tr key={rowIdx}>
                                                        <Each of={col.table?.dataColumns || []} fallback={
                                                          <td className="border border-gray-300 p-2">
                                                            <div className="h-3 bg-gray-200 rounded animate-pulse w-3/4 mx-auto" />
                                                          </td>
                                                        }>
                                                          {(dCol, dCIdx) => (
                                                            <td key={dCIdx} className="border border-gray-300 p-2" style={{ textAlign: dCol.align || 'left' }}>
                                                              <div className="h-3 bg-gray-200 rounded animate-pulse w-3/4 mx-auto" />
                                                            </td>
                                                          )}
                                                        </Each>
                                                      </tr>
                                                    )}
                                                  </Each>
                                                )}
                                              </>
                                            );
                                          })()}
                                        </tbody>
                                      </table>
                                    </div>
                                  </div>
                                );
                              }}
                            </Each>
                          )}
                        </div>
                      )}
                    </Each>
                  </div>
                </Show>
          </div>

          {/* Signature section - stays in body flow, appears once at the end */}
          <Show when={!!(footer && footer.rows && footer.rows.length > 0)}>
            <div className="w-full pt-8 pb-4">
              <div className="w-full block">
                <Each of={footer?.rows || []}>
                  {(row, rIdx) => (
                    <div 
                      key={rIdx} 
                      className="w-full mb-8 last:mb-0 block"
                      style={{ textAlign: 'center' }}
                    >
                      <Each of={row.columns || []}>
                        {(col, cIdx) => (
                          <div 
                            key={cIdx} 
                            style={{ 
                              display: 'inline-block', 
                              width: `${100 / (row.columns?.length || 1)}%`,
                              verticalAlign: 'top',
                              wordBreak: 'break-all', 
                              overflowWrap: 'anywhere'
                            }}
                            className={`text-sm text-center px-2 ${row.showBorder ? 'border border-black p-2' : ''}`}
                          >
                            <div className="block w-full">
                              <Show when={!!col.title}>
                                <div className="mb-1">{renderSignatureText(col.title)}</div>
                              </Show>
                              <Show when={!!col.title2}>
                                <div className="mb-1">{renderSignatureText(col.title2)}</div>
                              </Show>
                              
                              <div className="h-16" />
                              
                              <Show when={!!col.name}>
                                <div className="font-bold text-gray-800 underline underline-offset-4">{renderSignatureText(col.name)}</div>
                              </Show>
                              <Show when={!!col.role}>
                                <div className="text-xs text-gray-800 mt-1">{renderSignatureText(col.role)}</div>
                              </Show>
                              <Show when={!!col.role2}>
                                <div className="text-xs text-gray-500">{renderSignatureText(col.role2)}</div>
                              </Show>
                            </div>
                          </div>
                        )}
                      </Each>
                    </div>
                  )}
                </Each>
              </div>
            </div>
          </Show>

        </div>
    </div>
  );

  if (!isFitTable && mode === 'preview') {
    return (
      <div className="w-full flex-1">
        <div className="mx-auto" style={{ width: 'fit-content' }}>
          <div 
            className="bg-white shadow-lg"
            style={{ 
              width: `${width}mm`,
              minHeight: `${height}mm`,
              padding: '20mm 10mm 15mm 10mm',
              zoom: zoom
            }}
          >
            {rawContent}
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="w-full flex-1">
      <div className="mx-auto" style={{ width: 'fit-content' }}>
        <div 
          ref={targetRef} 
          className="pagedjs-preview-container flex flex-col gap-4"
          style={{
            zoom: zoom
          }}
        >
          {/* Paged.js will mount pages here */}
        </div>
      </div>
      
      {/* Hidden raw content to be consumed by Paged.js */}
      <div style={{ display: 'none' }}>
        <div ref={contentRef}>
          {rawContent}
        </div>
      </div>
    </div>
  );
}
