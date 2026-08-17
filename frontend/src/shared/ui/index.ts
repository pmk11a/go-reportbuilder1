// Data Components
export { ChartContainer, ChartTooltip, ChartTooltipContent, ChartLegend, ChartLegendContent, ChartStyle, type ChartConfig } from './data/chart';
export { Stat, type StatProps } from './data/stat';
export { Table, TableHeader, TableBody, TableFooter, TableHead, TableRow, TableCell, TableCaption, type TableProps } from './data/table';
export { Timeline, type TimelineItem, type TimelineProps } from './data/timeline';

// Feedback Components
export { Alert, AlertTitle, AlertDescription, type AlertProps } from './feedback/alert';
export { AlertDialog, AlertDialogTrigger, AlertDialogContent, AlertDialogHeader, AlertDialogFooter, AlertDialogTitle, AlertDialogDescription, AlertDialogAction, AlertDialogCancel } from './feedback/alert-dialog';
export { EmptyState, type EmptyStateProps } from './feedback/empty-state';
export { LoadingState, type LoadingStateProps } from './feedback/loading-state';
export { Progress, type ProgressProps } from './feedback/progress';
export { Skeleton, type SkeletonProps } from './feedback/skeleton';
// `Toast` component intentionally NOT re-exported — conflicts with the `Toast` interface from `@/shared/hooks/use-toast`.
// Import directly: import { Toast } from '@/shared/ui/feedback/toast'
export { Toaster } from './feedback/toaster';
export { Tooltip, TooltipTrigger, TooltipContent, TooltipProvider, type TooltipProps } from './feedback/tooltip';

// Form Components
export { Checkbox, type CheckboxProps } from './form/checkbox';
export { Counter, type CounterProps } from './form/counter';
export { DebouncedInput, type DebouncedInputProps } from './form/debounced-input';
export { FileUpload, type FileUploadProps } from './form/file-upload';
export { Form, FormField, FormItem, FormLabel, FormControl, FormDescription, FormMessage } from './form/form';
export { ImageUpload, type ImageUploadProps } from './form/image-upload';
export { Input, type InputProps } from './form/input';
export { Label, type LabelProps } from './form/label';
export { PasswordInput, type PasswordInputProps } from './form/password-input';
export { PhoneInput, type PhoneInputProps } from './form/phone-input';
export { RadioGroup, RadioGroupItem } from './form/radio-group';
export { Radio, type RadioProps } from './form/radio';
export { Rating, type RatingProps } from './form/rating';
export { RichTextEditor, type RichTextEditorProps } from './form/rich-text-editor';
export { SearchInput, type SearchInputProps } from './form/search-input';
export { SearchableSelect, type SearchableSelectOption } from './form/searchable-select';
export { Select, SelectTrigger, SelectValue, SelectContent, SelectItem } from './form/select';
export { Slider, type SliderProps } from './form/slider';
export { Switch, type SwitchProps } from './form/switch';
export { Textarea, type TextareaProps } from './form/textarea';
export { TimeInput, type TimeInputProps } from './form/time-input';

// Layout Components
export { Card, CardHeader, CardFooter, CardTitle, CardDescription, CardContent } from './layout/card';
export { Divider, type DividerProps } from './layout/divider';
export { ScrollArea, ScrollBar } from './layout/scroll-area';
export { Separator, type SeparatorProps } from './layout/separator';
export { Each, Show } from './layout/Render';

// Navigation Components
export { Breadcrumb, type BreadcrumbProps } from './navigation/breadcrumb';
export { DataPagination } from './navigation/data-pagination';
export { DropdownMenu, DropdownMenuTrigger, DropdownMenuContent, DropdownMenuItem, DropdownMenuCheckboxItem, DropdownMenuRadioItem, DropdownMenuLabel, DropdownMenuSeparator, DropdownMenuShortcut, DropdownMenuGroup, DropdownMenuPortal, DropdownMenuSub, DropdownMenuSubContent, DropdownMenuSubTrigger, DropdownMenuRadioGroup } from './navigation/dropdown-menu';
export { Menubar, MenubarMenu, MenubarTrigger, MenubarContent, MenubarItem, MenubarSeparator, MenubarLabel, MenubarCheckboxItem, MenubarRadioGroup, MenubarRadioItem, MenubarSubTrigger, MenubarSubContent, MenubarGroup, MenubarSub, MenubarShortcut } from './navigation/menubar';
export { Pagination, type PaginationProps } from './navigation/pagination';
// Sidebar primitive NOT re-exported — use the app-specific one from '@/shared/components/layouts/Sidebar'
// or import primitives directly: import { SidebarProvider, SidebarContent, ... } from '@/shared/ui/navigation/sidebar'
export { Steps, type StepsProps } from './navigation/steps';
export { Tabs, type TabsProps } from './navigation/tabs';

// Overlay Components
export { Accordion, type AccordionItem, type AccordionProps } from './overlay/accordion';
export { Avatar, AvatarImage, AvatarFallback, type AvatarProps } from './overlay/avatar';
export { AvatarGroup, type AvatarGroupProps } from './overlay/avatar-group';
export { Badge, type BadgeProps } from './overlay/badge';
export { BadgeGroup, type BadgeGroupProps } from './overlay/badge-group';
export { Button, buttonVariants, type ButtonProps } from './overlay/button';
export { Calendar, type CalendarProps } from './overlay/calendar';
export { Carousel, CarouselContent, CarouselItem, CarouselPrevious, CarouselNext, type CarouselApi } from './overlay/carousel';
export { Chip, type ChipProps } from './overlay/chip';
export { Code, type CodeProps } from './overlay/code';
export { Collapse, type CollapseProps } from './overlay/collapse';
export { Collapsible, CollapsibleTrigger, CollapsibleContent } from './overlay/collapsible';
export { Command, CommandDialog, CommandInput, CommandList, CommandEmpty, CommandGroup, CommandItem, CommandSeparator, CommandShortcut } from './overlay/command';
export { DeleteConfirmationDialog } from './overlay/delete-confirmation-dialog';
export { Dialog, DialogTrigger, DialogContent, DialogHeader, DialogFooter, DialogTitle, DialogDescription, DialogClose } from './overlay/dialog';
export { Kbd, type KbdProps } from './overlay/kbd';
export { NotificationBadge } from './overlay/notification-badge';
export { Popover, PopoverTrigger, PopoverContent } from './overlay/popover';
export { Sheet, SheetTrigger, SheetContent, SheetHeader, SheetFooter, SheetTitle, SheetDescription } from './overlay/sheet';
export { Spinner, type SpinnerProps } from './overlay/spinner';
export { Tag, TagGroup, type TagProps } from './overlay/tag';
