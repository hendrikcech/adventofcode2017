import Control.Arrow (first, second)
import qualified Data.Map.Strict as Map
import Data.Maybe (fromJust)

data Dir = R | U | L | D
  deriving Show

nextDir :: Dir -> Dir
nextDir R = U
nextDir U = L
nextDir L = D
nextDir D = R

-- step count increases on every left and right turn
doesTurnIncStepsPerSide :: Dir -> Bool
doesTurnIncStepsPerSide L = True
doesTurnIncStepsPerSide R = True
doesTurnIncStepsPerSide _ = False

type Pos = (Int, Int)

data State = MkState { square :: Int
                     , pos :: Pos
                     , facing :: Dir
                     , stepsUntilTurn :: Int
                     , totalSteps :: Int
                     , value :: Int
                     , values :: Map.Map Pos Int
                     }
  deriving Show

startState :: State
startState = MkState { square = 3
                   , pos = (0,1)
                   , facing = U
                   , stepsUntilTurn = 1
                   , totalSteps = 1
                   , value = 1
                   , values = Map.fromList ([((0,0), 1), ((0,1), 1)])
                   }

-- for part 2
data EvaluationType = Straight Dir | PreTurn Dir | Turn Dir

squareEvalutionType  :: State -> EvaluationType
squareEvalutionType state | stepsUntilTurn state == 0 = Turn $ nextDir $ facing state
                          | stepsUntilTurn state == 1 = PreTurn $ facing state
                          | otherwise = Straight $ facing state

neighboursOfPos :: Pos -> EvaluationType -> [Pos]
neighboursOfPos (row, col) squareType = applyToPos <$> calc squareType
  where
    applyToPos (row', col') = (row+row', col+col')
    calc (Straight U) = [(0, -1), (-1, -1), (1, -1), (1, 0)]
    calc (Straight L) = [(0, 1), (1, 1), (1, 0), (1, 0-1)]
    calc (Straight D) = [(-1, 0), (-1, 1), (0, 1), (1, 01)]
    calc (Straight R) = [(0, -1), (-1, -1), (-1, 0), (-1, 1)]
    calc (PreTurn U) = [(1,0), (1, -1), (0, -1)]
    calc (PreTurn L) = [(1, 0), (1, 1), (0, 1)]
    calc (PreTurn D) = [(0, 1), (-1, 1), (-1, 0)]
    calc (PreTurn R) = [(0, -1), (-1, -1), (-1, 0)]
    calc (Turn U) = [(0, -1), (-1, -1)]
    calc (Turn L) = [(1, 0), (1, -1)]
    calc (Turn D) = [(0, 1), (1, 1)]
    calc (Turn R) = [(-1, 0), (-1, 1)]

calculateValue :: State -> Int
calculateValue state =
  let
    squareType = squareEvalutionType state
    neighbours = neighboursOfPos (pos state) squareType
  in
    sum $ fromJust <$> (\p -> Map.lookup p (values state)) <$> neighbours

evaluatePos :: State -> State
evaluatePos state =
  let
    key = pos state
    value = calculateValue state
  in
    state { values = Map.insert key value (values state)
          , value = value
          }

---

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
turn state =
  let
    facing' = nextDir $ facing state
    steps = totalSteps state
    stepsOnThisSide = if doesTurnIncStepsPerSide facing' then steps + 1 else steps
  in
    state { facing = facing'
          , stepsUntilTurn = stepsOnThisSide
          , totalSteps = stepsOnThisSide
          }

step :: State -> State
step state
    | (stepsUntilTurn state > 0) = evaluatePos . move $ state
    | (stepsUntilTurn state == 0) = evaluatePos . move . turn $ state

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

searchValue inputValue state =
  let
    state' = step state
    value' = value state'
  in
    if value' > inputValue
    then value'
    else searchValue inputValue state'


main :: IO ()
main = do
  let state = searchSquare 277678 startState
  let d = distance (0,0) $ pos state
  print $ "Distance: " ++ show d

  let v = searchValue 277678 startState
  print $ "First value > puzzle input: " ++ show v
