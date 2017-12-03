import Control.Arrow (first, second)

data Dir = R | U | L | D
  deriving Show

nextDir :: Dir -> Dir
nextDir R = U
nextDir U = L
nextDir L = D
nextDir D = R

type Pos = (Int, Int)

data State = MkState { square :: Int
                     , pos :: Pos
                     , facing :: Dir
                     , stepsUntilTurn :: Int
                     , stepsPerSide :: Int
                     , turnsToStepInc :: Int
                     }
  deriving Show

startState :: State
startState = MkState { square = 1
                   , pos = (0,0)
                   , facing = R
                   , stepsUntilTurn = 1
                   , stepsPerSide = 1
                   , turnsToStepInc = 2
                   }

move :: State -> State
move state = state { square = (square state) + 1
                   , pos = newPos (facing state) (pos state)
                   , stepsUntilTurn = (stepsUntilTurn state) - 1
                   }
  where
    newPos :: Dir -> (Int, Int) -> (Int, Int)
    newPos R = second (+ 1)
    newPos U = first (subtract 1)
    newPos L = second (subtract 1)
    newPos D = first (+ 1)

turn :: State -> State
turn state = state { facing = nextDir $ facing state
                   , turnsToStepInc = (turnsToStepInc state) - 1
                   }

updateStepState :: State -> State
updateStepState state =
  state
  { stepsUntilTurn = newStepsUntilTurn $ turnsToStepInc state
  , stepsPerSide = newStepsUntilTurn $ turnsToStepInc state
  , turnsToStepInc = newTurnsToStepInc $ turnsToStepInc state
  }
  where
    newStepsUntilTurn 0 = (stepsPerSide state) + 1
    newStepsUntilTurn n = stepsPerSide state
    newTurnsToStepInc 0 = 2
    newTurnsToStepInc n = n

step :: State -> State
step state
    | (stepsUntilTurn state > 0) = move state
    | (stepsUntilTurn state == 0) = move . updateStepState . turn $ state

-- calculate manhatten distance
distance :: Pos -> Pos -> Int
distance (a, b) (x, y) = abs (a - x) + abs (b - y)

-- execute

walkN :: Int -> State -> State
walkN 0 state = state
walkN steps state = walkN (steps - 1) (step state)

walkNwrite :: Int -> State -> IO ()
walkNwrite 0 state = print state
walkNwrite steps state =
  let nextState = step state
  in do
    if square state /= square nextState then print state else return ()
    walkNwrite (steps - 1) nextState

searchSquare :: Int -> State -> State
searchSquare sq state =
  let
    nextState = step state
    nextSquare = square nextState
  in
    if nextSquare == sq
    then nextState
    else searchSquare sq nextState

main :: IO ()
main = do
  let state = searchSquare 277678 startState
  print state
  let d = distance (0,0) $ pos state
  print d
