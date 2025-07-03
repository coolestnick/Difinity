import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';
import type { IDL } from '@dfinity/candid';

export type Result = { 'ok' : string } |
  { 'err' : string };
export interface _SERVICE {
  'chatWithTools' : ActorMethod<[string], Result>,
  'getStats' : ActorMethod<
    [],
    { 'timestamp' : bigint, 'requestCount' : bigint }
  >,
  'health' : ActorMethod<[], string>,
  'simpleChat' : ActorMethod<[string], Result>,
}
export declare const idlFactory: IDL.InterfaceFactory;
export declare const init: (args: { IDL: typeof IDL }) => IDL.Type[];
