open Scxml

module TestElements = struct
  let mkState =
    Elements.State.
      {
        id = "test-state-1";
        initial = "going-nowhere";
        children = [ `OnEntry ];
      }

  let mkParallel = Elements.Parallel.{ id = "test-parallel-1" }

  let mkTransition =
    Elements.Transition.
      { event = None; cond = None; target = Some "test-state-1"; _type = None }

  let mkInitial = Elements.Initial.{ id = None }
  let mkFinal = Elements.Final.{ id = Some "final-state-1" }
  let mkOnEntry = Elements.OnEntry.OnEntry
  let mkOnExit = Elements.OnExit.OnExit
  let mkFinalize = Elements.Finalize.Finalize

  let mkHistory =
    Elements.History.
      { id = Some "history-element-1"; _type = Some "deep-history-x" }

  let mkScript = Elements.Script.{ src = Some "get-some-data.js" }

  let mkData =
    Elements.Data.
      { id = "some-data"; src = Some "get-some-data.js"; expr = None }
end
