export const idlFactory = ({ IDL }) => {
  const Result = IDL.Variant({ 'ok' : IDL.Text, 'err' : IDL.Text });
  return IDL.Service({
    'chatWithTools' : IDL.Func([IDL.Text], [Result], []),
    'getStats' : IDL.Func(
        [],
        [IDL.Record({ 'timestamp' : IDL.Int, 'requestCount' : IDL.Nat })],
        ['query'],
      ),
    'health' : IDL.Func([], [IDL.Text], ['query']),
    'simpleChat' : IDL.Func([IDL.Text], [Result], []),
  });
};
export const init = ({ IDL }) => { return []; };
