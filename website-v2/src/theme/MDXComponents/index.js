// Import the original mapper
import MDXComponents from "../MDXComponentsOriginal/index";
import Tabs from "@theme/Tabs";
import TabItem from "@theme/TabItem";
import DocCard from "@theme/DocCard";
import DocCardList from "@theme/DocCardList";
import FernSchema from "../../components/FernSchema";
import { Files, Folder, File } from "../../components/FileTree";
import {
  EndpointRequestSnippet,
  EndpointResponseSnippet,
  EndpointSchemaSnippet,
  SchemaSnippet,
  WebhookPayloadSnippet,
} from "../../components/FernApiSnippets";

// Custom components
import { Language, LangItem } from "../../components/Language/Language";
import LangSwitch from "../../components/Language/LangSwitch";
import { AlphaBadge, BetaBadge } from "../../components/AlphaBetaBadges";
import { APITable, APITableRow } from "../../components/APITable";
import { SharedTable } from "../../components/SharedTable";
import { UseCaseView, UseCaseLinks } from "../../components/HomepageFeatures";
import Steps from "../../components/Steps";
import Subtitle from "../../components/typography/Subtitle";
import { Accordion, AccordionGroup } from "../../components/Extras/Accordion";
import { Card, CardGroup } from "../../components/Extras/Card";
import Frame from "../../components/Extras/Frame/Frame";
import Slideshow from "../../components/Extras/Slideshow/Slideshow";
import Tooltips from "../../components/Extras/Tooltips";
import { PreviewCardGroup, PreviewCard } from "../../components/Extras/PreviewCard";

import { GuidesList, GuidesListMirror } from "../../components/GuidesList";
import ReleaseCard from "../../components/Blog/ReleaseCard";
import Tables from "../../components/Tables";
import APIBadge from "../../components/APIBadge";
import APIField from "../../components/APIField";
import InstallHero from "../../components/InstallHero";

// Fern-compatible components
import ParamField from "../../components/ParamField";
import { Warning, Info, Tip, Note, Success, Error } from "../../components/FernCallouts";
import Indent from "../../components/Indent";
import { CodeBlocks, CodeBlock as FernCodeBlock } from "../../components/CodeBlocks";
import Step from "../../components/Step";
import Tooltip from "../../components/Tooltip";
import Button from "../../components/Button";
import Icon from "../../components/Icon";

export default {
  ...MDXComponents,

  Language,
  LangItem,
  LangSwitch,
  Frame,

  Tabs,
  TabGroup: Tabs,
  TabItem,
  Accordion,
  AccordionGroup,
  AlphaBadge,
  BetaBadge,

  APITable,
  APITableRow,
  SharedTable,

  Card,
  CardGroup,
  Cards: CardGroup,

  DocCard,
  DocCardList,
  Frame,
  PreviewCardGroup,
  PreviewCard,
  Slideshow,
  Steps,
  Subtitle,
  UseCaseLinks,
  UseCaseView,
  Tooltips,
  GuidesList,
  GuidesListMirror,
  ReleaseCard,
  Tables,
  APIBadge,
  APIField,
  InstallHero,

  // Fern-compatible components
  ParamField,
  Warning,
  Info,
  Tip,
  Note,
  Success,
  Error,
  Indent,
  CodeBlocks,
  CodeBlock: FernCodeBlock,
  Step,
  Tooltip,
  Button,
  Icon,
  Schema: FernSchema,

  // File tree components
  Files,
  Folder,
  File,

  // API snippet stubs (Fern-specific)
  EndpointRequestSnippet,
  EndpointResponseSnippet,
  EndpointSchemaSnippet,
  SchemaSnippet,
  WebhookPayloadSnippet,
};
