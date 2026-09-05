#import "@preview/itemize:0.1.2" as el
#set enum(numbering: "1. a. i.")
#set par(justify: true)
#set text(font: "New Computer Modern", size: 0.71em)
#let pmod-spacing = state("pmod-spacing", 2em/9)
#show math.equation.where(block: true): it => {
  pmod-spacing.update(2em/9)
  it
}
#show math.equation.where(block: false): it => {
  pmod-spacing.update(2em/9)
  it
}
#show math.equation.where(block: false): box
#let pmod(m) = context h(pmod-spacing.get()) + $(mod med #m)$
#show math.frac: math.display
#set page(paper: "a4", numbering: "1", margin: 12pt)

#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()
#codly(
  number-format: none,
  zebra-fill: none,
  smart-indent: false,
  display-icon: false,
  display-name: false,
  fill: rgb(250,250,250)
  )
  
#columns(3, gutter: 11pt)[
  #text(size: 20pt, weight: "bold")[CS 12 Cheatsheet]
  #text(size: 12pt)[Diogn Lei R. Mortera]

  202508438 $dot$ Seat [ \_\_\_\_ ] $dot$ TCD/FRU2

  = Asynchronous Programming

  *blocking operations* done sequentially

  *thread of execution* sequence of instructions executed one after another, 1 program - 1 thread (default), web browsers usually have 1 thread
  
  *optimization* multiple requirements at the same time, related to...
  
  *nonblocking operations* lets other tasks run even if its not finished
  
  *coroutines* capable of un/pausing own execution
  
  *concurrency* the interweaving of coroutines

  *event loop* inf. loop managing concurrent execution of coroutines
  
  *async functions* returns `Awaitable[[...], ...]` that must be awaited to be executed
  
  *serialization* complex data to string format (e.g. `dict -> JSON`), `json.dumps()`
  
  *deserialization* string format to complex data (e.g. `JSON -> dict`), `json.loads()`
  
  *application programming interface* some form of protocol managing communication between sender and receiver

  ```py
  import httpx
  async def #makes a function a coroutine
  await #makes sure a coroutine finishes at that line before proceeding to the next parts of that stack frame
  import asyncio 
  .run(f()) |  .sleep(n) | 
  .gather(f(),g()) # runs all at same time, waits for all to finish
  .create_task(f()) # starts running task f() in the background

  async with httpx.AsyncClient() as client:
    res = await client.get(f'{API_ENDPOINT}/{id&etc.}/', params=params)

  JSON null -> Python None
  # if not valid JSON, json.decoder.JSONDecodeError
  # if value cannot be serialized to JSON, TypeError
  ```
  = Elm
  == Basics

  Evan Czaplicki, 2012, functional programming for front-end web apps, purely immutable, statically typed, safe type system, no runtime errors

  *miscellaneous* no loops, use recursion, exploit `(List|String).map`
  
  *variables* must start lowercase, and not indented, no reassignment
  
  *statement* is not a valid function return value
  
  *expression* evaluates to value
  
  *shadowing* reuse of a variable in some declaration, will just give you a warning _but the code still runs so be careful!_

  *type inferring* works, but prefer to type-hint stuff for easier debugging

  *immutability of containers* since variables / values / containers cannot be mutated, nothing is added or removed; thats an entirely new value

  == Fold

  *fold* abstraction of for-each aggregation pattern (also known as reduce, accumulate, aggregate)

  ```elm
  sum = List.foldl (+) 0 [1,2,3]
  reverse = List.foldl (::) [] [1,2,3,4,5,6]
  ```
  
  == Algebraic Data Types

  *type alias* gives new name to existing type
  
  *composite type* type composed of other types (tuple, list, array, dict)
  
  *product type* (and) and *sum type* (or) and *algebraic data type* (composition of both)
  
  *tagged unions* union type with tag, identifying which type is in use
  
  *tag* data used to identify which variant a tagged union value is

  *extensible records* typing for "record with at least some fields"
  ```elm 
  -- creation of new type
  type Color = R | O | Y | G | B | I | V
  -- type alias
  type alias Name = String
  type alias Point2D = { x:Float, y:Float }
  -- composite
  Bullet = (Point2D, Color)
  Magazine = List Bullet
  -- product type
  type Gun = { mags : Magazine, name : Name }
  -- tagged union
  type Genre =
    OPM String | KPop String Int | EDM String Float
  type Maybe a = Just a | Nothing
  type Result e a = Ok a | Err e
  -- extensible records: `greet` takes in any record with those attributes
  greet : {r | name : String} -> String
  ```
  
  ==  MVU
  model-view-update
   #grid(
    columns: (1fr, 1fr),
    align: center,
    image("image (7).png"),
   image("image (8).png", width: 95%)
  )

  = C

  *variables* cannot be used when undeclared | cannot be redefined _in the same scope_ | contain garbage when not assigned | `snake_case`

  *initialization* initialization = declaration + assignment | `const` variables must be initialized

  *top level* source code outside any block
  
  *global variable* declared in top level
  
  *local variable* declared inside some block | usage valid if declaration is in enclosing block
  
  *preprocessor directives* construct that specifies how a compiler should process its input (`define, ifdef, ifndef`)

  *staying within data type limits* algebraic manipulation | typecast to wider type

  #align(center)[
  #set text(size: 5pt)
  #table(
    columns: (auto, auto, auto, auto),
    inset: 2pt,
    stroke: 0.1pt,
    table.header(
      [*Signed Type*], [*Specifier*], [*Unsigned Type*], [*Specifier*],
    ),
    [`char`],              [`%hhd`],              [`unsigned char`],      [`%hhu`],
    [`short`],             [`%hd`],               [`unsigned short`],     [`%hu`],
    [`int`],               [`%d`],                [`unsigned int`],       [`%u`],
    [`long`],              [`%ld`],               [`unsigned long`],      [`%lu`],
    [`long long`],         [`%lld`],              [`unsigned long long`], [`%llu`],
    [`ssize_t`],           [`%zd`],               [`size_t`],             [`%zu`],
    [`int8_t`],            [`"%" PRId8`],         [`uint8_t`],            [`"%" PRIu8`],
    [`int16_t`],           [`"%" PRId16`],        [`uint16_t`],           [`"%" PRIu16`],
    [`int32_t`],           [`"%" PRId32`],        [`uint32_t`],           [`"%" PRIu32`],
    [`int64_t`],           [`"%" PRId64`],        [`uint64_t`],           [`"%" PRIu64`],
  )
  ]
  change `d` or `u` above to `x` for lowercase hex, and `X` for uppercase hex

  *sequence points* `(; , && ?: f)` if variable modified twice within a sequence, then it is undefined behavior
  == Memory

  *memory* array of bytes | usually $2^64$ | all data of a running program | "address-value dict"

  *Heisenbug* behavior changes when "observed" (or when something unrelated is added)

  *null pointer* special address value (usually `0`) representing absence of value being pointed to | `NULL` | `#include <stdlib.h>`

  *segmentation fault* program attempts to access memory address it has no permission to

  *overflow* the desired number gets "modulo-ed" under the limits of current datatype
  == Pointers 

  === Behavior
  - when a function call is done, allocated memory is _deallocated_
  
  === Rules
  - never return pointers to local variables
  - `free()` unused memory
  - watch out for array out-of-bounds errors
  - when creating arrays inside blocks to return, use heap memory (`malloc()`) instead of stack-based
  - you cannot dereference a null pointer

  == Dynamic Memory Allocation

  *stack memory* region for call stack and local vars | faster to access | allocations active until end of function; deallocated automatically
  
  *heap memory*  for dynamic allocation | slower to access | "unlimited" | allocate with `malloc(n*size)` or `calloc(n, size)`| manual deallocation via `free(<ptr>)`

  *Bugs*
  - Use-after-free (UAF)
  - Double free (cause of security bugs) (CVE-2025-3066, CVE-2023-42950)
  - Memory leak (heap memory that can't be deallocated due to losing all references to it)

  *Types of Allocations*
  - Single continuous allocations -  exploiting math to index 
  - Separate contiguous allocations - exploiting nested pointers

  == Multithreaded Programming

  *concurrency* multiple tasks in given span of time with possible interleaving
 vs. *parallelism* multiple tasks at same time | multicore processor
  
  *thread* current instruction + call stack + environment | single core
  
  *shared-state concurrency* communicate via shared memory
  
  *message-passing concurrency* communicate via messages (out of scope)
  
  *race condition* behavior depends on nondeterministic order of thread execution
  
  *critical section* region with possible race condition
  
  *mutual exclusion* at most one thread executing critical section at any time
  
  *lock/mutex* enforces mutual exclusion | lock only acquired if free/released | $<=$1 thread per lock | can introduce additional overhead, try to minimize
  
  *minimize un/locking operations* summarizing each thread before updating global variable
]

  





 
#pagebreak()



#set text(size: 0.63em)

#columns(4, gutter: 10pt)[
  #text(size: 20pt, weight: "bold")[References] #text(size: 0.1pt)[.]

  
  = Async Programming


  == Async Fun 

  ```py
  import asyncio
  async def say(msg, delay):
      await asyncio.sleep(delay); print(msg)
  async def main():
      # (.gather(), order of completion depends on delay, not declaration order
      await asyncio.gather(
          say("A (delay 2)", 2),
          say("B (delay 1)", 1),
          say("C (delay 3)", 3),
      ) # prints: B,A,C
      # .create_task() — fire and forget; runs in background
      # main() continues immediately after create_task
      task = asyncio.create_task(say("I run in the background", 1))
      print("This prints BEFORE the task finishes")
      await task
      print("Now the task is done")
  # NOTE: "await" makes things sequential ONLY WITHIN THAT COROUTINE
  asyncio.run(main())
  #`create_task` just registers the coroutine with the event loop. The event loop only gets to actually run worker when main hits an await and suspends itself.
  #`await t` suspends coroutine currently executing & returns control to the event loop
  ```
  
  = Elm Basics

  == Miscellaneous
  ```elm
  identity  always  |>  <|

  -- CONDITIONALS
  crushKaBa = 
    if eyeContact == True then
      "Siguro"
    else if clingy == True then 
      "Probably"
    else
      "No chance"

  pairUp lis =
    case lis of
      x :: rest -> List.map (\el -> (x, el)) rest ++ (pairUp rest)
      [] -> []
  ```

  == Types

  ```elm
  Bool, Int, Float 
  Char  'a','😘',\u{1F648}
  String  "hello","a\nc","\"","""A"""
  ```
  
  == Math 
  ```elm
  + - // / /= == ^ ++
  modBy remainderBy max min not xor isNan isInfinite
  2^3^2 == 512
  ```

  == Lists
  ```elm
  singleton repeat range ::
  length reverse member maximum minimum
  sum product
  append -- combine 2 lists
  concat : List (List a) -- combine a list of lists
  intersperse
  drop take unzip map filter
  ```
  == String
  ```elm
  replace repeat startsWith reverse join words lines slice left right dropLeft dropRight contains
  ```

  == Modules
  ```elm
  import ModuleName exposing (Type1, func1, func2)
  import ModuleName exposing (..)
  ```

  == Dict 
  ```elm
  get idx dict | insert idx new_el dict
  member size keys values toList fromList union intersect
  ```
  == Char
  ```elm
  isUpper/Lower/Alpha/AlphaNum/Digit toUpper/Lower
  ```

  == Interesting Types 
  ```elm
  Maybe a = Just a | Nothing
  a = Just 10  -- Maybe Int      
  b = Nothing  -- Maybe a
  ```
  
  = Fold

  ```elm 
  type alias UPStudent =
  { year : Int, campus : Str }
  diognFreshie = { year = 1, campus = "Diliman" } 
  diognSophie = { diogn | year = diognFreshie.year + 1 }
  ```

  ```elm
  def fold(REDUCER, STARTING_VALUE, elems):
     result = STARTING_VALUE
     for elem in elems:
        result = REDUCER(elem, result)
     
     return result

  // order matters for noncommutative reducers!

  // REDUCER -> STARTVAL -> ELEMS -> RESULT
  // foldl : (a -> b -> b) -> b -> List a -> b
  ```

  ```elm
  compress: List a -> List a -- code from Lab 09a
  compress lis =
    let
        reduce el acc =
            case acc of 
                x :: xs ->
                    if x == el then acc 
                    else el :: acc
                [] -> [el]
    in List.foldl reduce [] lis |> List.reverse

  ```
  
  = Elm MVU
  ```elm
  module Main exposing (main)
  
  import Browser
  import Html exposing (Html, div, text, p, input, br)
  import Html.Events exposing (onInput, onClick)
  
  type Msg = ...
  type alias Model = ...
  
  init: Model
  init = ...
  
  update: Msg -> Model -> Model
  update msg model = ...
                  
  view : Model -> Html Msg
  view model = ...
  
  main : Program () Model Msg
  main =
      Browser.sandbox { init = init, update = update, view = view }
  ```

  == Important Components
  ```elm
  type Msg = 
    MsgButtonClicked | MsgOninput String | MsgAdd5 Int String | MsgSelect String
  
  div [ style "border" "1px black solid" ] [] --div
  button [ onClick MsgButtonClick ] [ "Click me" ] --button
  input [ onInput (MsgAdd5 5), placeholder "Number here" ] [] -- onInput with addt'l param in event listener
  -- select with options
  select [ onSelect (MsgSelect) ] [
    option [] ["1"], option [] ["2"]
  ] 
  ```

  == Fetching

  ```elm
module Main exposing (main)

import Browser
import Debug
import Html exposing (..)
import Html.Events exposing (onClick)
import Http

type Model = LoadWeather | ShowWeather String | ErrorPage String

type Msg = RefetchWeather | MsgGotString (Result Http.Error String)

getWeatherFromAPI : Cmd Msg
getWeatherFromAPI =
    Http.get
        { url = "https://wttr.in/?format=3"
        , expect = Http.expectString MsgGotString
        }

init : () -> ( Model, Cmd Msg )
init _ = ( LoadWeather, getWeatherFromAPI )

update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        RefetchWeather -> ( LoadWeather, getWeatherFromAPI )

        MsgGotString res ->
            case res of
                Ok ok -> ( ShowWeather ok, Cmd.none )
                Err err -> ( ErrorPage (Debug.toString err), Cmd.none )

view : Model -> Html Msg
view model =
    div []
        [ case model of
            LoadWeather -> text "Loading..."
            ShowWeather weather -> text weather
            ErrorPage error -> text error
        , button [ onClick RefetchWeather ] [ text "Refetch" ]
        ]

subscriptions : Model -> Sub Msg
subscriptions _ = Sub.none

main : Program () Model Msg
main = Browser.element
        { init = init, update = update, view = view, subscriptions = subscriptions }
  ```
  = C

  ```c
  #include <stdio.h> int main() { printf("Hi\n"); return 0; }
  ```
  
  ```c 
  gcc file.c -o output && ./output
  gcc file1.c file2.c -o output && ./output
  ```

  ```c
  // all lines end in '}',':','}'
  // preprocessor directives are not statements
  ```

  *Variables*
  ```c
  int x; int y, z; //declaration
  x = 1, y = 2, z = 3; //assignment
  int m = 5; //initialization
  const int o = 7; //constant variable
  const int n; //impractical
  ```

  *Operators and Control Structures*
  ```c
  int certainty = 101;
  char are_you_sure[] = certainty > 100 ? "yes" : "no"; //ternary (right associative)
  a ? b : c ? d : e = a ? b : (c ? d : e)
  // on bools: 0 -> False, nonzero -> True
  ```

  *Data Types*
  ```c
  unsigned : [0, (2^n)-1] 
  signed : [-2^{n-1}, 2^{n-1} -1]
  2^8 = [0, 255] [-128, 127]
  2^32 = [0, 4294967295] [-2147483648,2147483647]
  2^64 = [0, 18446744073709551616] [-9223372036854775808,9223372036854775807]
  
  #include <stdint.h> 
  #include <inttypes.h>
  
  // unsigned | signed
  8 - unsigned char, uint8_t | char, int8_t
  32 - unsigned int, uint32_t | int, int32_t
  64 - unsigned long long, size_t, uint64_t | long long, ssize_t, int64_t
  ```

  *Arrays*
  ```c
  int nums[5] = {67, 420}; //initializes last 3 to 0 
  int nums[] = {67, 420}; //infer size 2
  // cannot expand once declared | must keep track of element count
  // will not crash on OOB reads/writes, good luck debugging!
  int nums2d[6][7] = {}; //initialize all to 0
  int nums2d[6][7]; //garbage
  ```

  *Casting*
  ```c
  // implicit typecasting
  long long x = 2e10;
  int y = x; // 2e10 > the size so there is undefined behavior
  ```
  
  *Formatting*
  ```c
  printf("%format1 some text here %format2 ...", var1,var2,...)

  %d (signed int) %c (char) %u (unsigned int) %f (float) %s (string) %p (pointer) %ld (long int) %li (long int) %lld (long long) %lu (long unsigned int) 
  PRIu64 (uint64_t) PRId64 (int64_t)
  
  %20 #right alignment
  %-20 #left alignment
  %.5 #field width
  ```
  
  == Memory
  ```c 
  sizeof(x) // no, bytes (8 bits) used in datatype
    1 - char, uint8_t
    2 - short
    4 - int, float, uint32_t
    8 - long, long long, double, uint64_t, (void *) 
    16 - long double
  ```

  *Pointer*
  ```c
  (char *) // char pointer type
  char *p // p - variable containing address, this address contains some char

  & // address-of operator
  * // dereference operator

  // adding 1 to pointer moves it to address of next element
  ```

  ```c 
  void add(int *p, int a) { *p = *p + a; }
  
  int main() {
    int x = 12;
    add(&x, 12)
    printf("%d", x) // 24
  }
  // pass-by-value
  // if iterating through array, PASS ARRAY BOUNDS
  ```

  ```c
  int *p = NULL; // do NOT try to dereference this!
  ```
  
   *Pointer Fun*
  ```c
  // TIP: read right to left to see what the pointer points to

  const char *s //pointer to a (const char)
  char *const s //s is a (const pointer) to char
  
  const char *word = "yes"; // can change pointer, but not contents
  word = "no"; // allowed
  word[0] = "N"; // not allowed

  p[i] == *(p+i) == arr[i]
  arr = &arr[0]
  arr++ // is undefined. use
  int p* = arr; p++;
  ```

  *Segfault Causers*
  ```c
  int *p = NULL;
  int x = *p; // SF, dereferencing null pointer

  int x = 67;
  int *p = &x + 9999999999; // no segfault yet
  int y = *p; // segfault on access

  int *p;
  int x = *p; // likely SF because garbage address
  *p = 42;  // SF, writing to unknown address
  
  char *str = "Dio?n";
  str[3] = 'g'; // SF, read-only memory
  char str[] = "Dio?n";
  str[3] = 'g'; // NOT SF, stack is writable
  char *str = malloc(7);
  strcpy(str, "Dio?n");
  str[3] = 'g'; // NOT SF, heap is writable

  str[100]; // probably SF
  str[1000000000]; // even more likely SF
  ```

  *Multiple Levels of Indirection*

  ```c
  int a = 10; int *p = &a; int **pp = &p;
  a == *p == **pp
  ```

  *Input*
  ```c
  scanf(<format_specifier_string>, <ptr1>, ...)

  %d (int *), %f // ignores trailing whitespace, checks for "+" and "-", then digits, then stops at first non-digit
  %s (char[]) // ignores trailing whitespace, eats nonwhitespaces, stops at first whitespace
  %c (char *) // first character (any)

  fgets(<char_ptr>, <n>, <input_stream>)
  // stops when '\n' is eaten, (n-1) characters eatem, input stream closed, appends '\0' to output
  stdin // standard input stream

  atoi(<array>) // int equivalent of null-terminated string, stops at whitespace
  ```

  *Structs*
  ```c 
  typedef struct shulkerbox ShulkerBox;

  struct shulkerbox {
    ShulkerBox *inner_box;
    int weight;
  }

  typedef struct { char name[50]; int year; } Person;
  // p->att = (*p).att
  
  void f1(int *year) { *year = *year + 1; }
  void f2(Person *p) { 
    int *q = &(*p).year; // &((*p).year)
    *q = (*p).year + 1; }
  void f3(Person *p) { 
    int *q = &p->year; // &(p->year)
    *q = p->year + 1
  }
  ```

  *Dynamic Memory Allocation*

  ```c
  int *int_heap_array(int n) {
    int* arr = malloc(n * sizeof(int) );
    return arr; }
  arr = int_heap_array(67);
  // use arr here i guess
  free(arr); // sidenote: free(NULL) is safe
  ```
  
  ```c
  #include <stdlib.h>
  malloc(<size to allocate>)
  calloc(<n>, <size_each>) // init all w/ 0

  // Single contiguous allocation (what stack-based 2D array does)
  cont = malloc(Z_CNT*Y_CNT*X_CNT * sizeof(int)) // 1st and 2nd in one declaration
  cont[z][y][x] == cont + (z*Y_CNT*X_INT) + (y*X_CNT) + x 
  
  // Separate contiguous allocation
  cont = malloc(ROWS * sizeof(void **)) // entire thing
  cont[0<=i<=Z_CNT-1] = malloc(Y_CNT * sizeof (void *) ) // 1st level
  cont[0<=i<=Z_CNT-1][0<=j<=Y_CNT-1] = malloc(X_CNT * sizeof(int) ) // 2nd level
  cont[z][y][x] == *(*(*(cont+z)+y)+x)
  ```

  *Multithreaded Programming*
  ```c
  #include <pthread.h>
  int pthread_create(p_tid, attrs, function, arg)
  pthread_t *p_tid
  pthread_attr_t *attrs //NULL for cs12

  void *(*function)(void *)

  // ++ and -- are race condition prone because they're "multiple steps" in the Assembly level

  pthread_join(tid, NULL); // "await" thread finish before proceed
  pthread_mutex_t lock;
  pthread_mutex_init(*lock, NULL) // initialize
  pthread_mutex_lock(*lock) // acquire
  pthread_mutex_unlock(*lock) // release
  ```
  
  = References
  #image("image (2).png")

  #set par(spacing : 0.6em)

  === Bonus
  #text(size : 3.4pt)[

  === OJ Names that can be Found

  Lab 11: 
  a) Rumi - bday, Jinu - Rumi Friend (gift)
  b) Kevin - Minecraft shulker box 
  c) Nagoya Inoue - boxing problem (Area of boxing point p)
  d) Maxna Sum Laude - name of award
  e) Letterman and Numberman (Alphanum Sorter)
  f) Mr. A^T (the linear algebra one)
  g) Bob - CS Student who learned abt Middle Square Method
  
  Lab 12: 
  a) Professor Hojo - Research station
  b) Professor Hojo - subregion
  c) Aliens attacking Earth
  d) Sk8r Boi - Cheap Skates
  e) Gollum - Gollum Columns
  f) Link - Linked list (Lol)

  === Instructors
  #text(size : 1em)[
    Jerome Cary Beltran, Daryll Carlsten Ko, Miguel Martinez, Jozelle Addawe, Ren Tristan Dela Cruz, Mario Carreon, #strike[Juan Felipe Coronel]
  ]

  === Student Assistants
  #text(size : 1em)[
    Vaughn Aquino $dot$
    Eliana Mari Lim $dot$
    Charlize Sim $dot$
    Gabby Sacramento $dot$
    Aeron Dann Peñaflorida $dot$
    Jarelle Gail Ricaforte $dot$
    Lucas Agcaoili $dot$
    Marius Ulyzses Barcenas $dot$
    Tristan Jovan Noval
  ]
  
  == Credits

  #text(size : 1em)[
  Diogn Mortera - cheatsheet | Anonymous Source - OJ Names that can be found
  ]

  ==  Motivational Quotes

  #text(size : 1em)[
  "We're alive 'cause we are not alone" -_Run for Roses_, NMIXX
  
  "I'm unraveled (I'm unraveled)" -_the cure, Olivia Rodrigo_

  "One might wish you good luck, however luck is merely an illusory essentialization of statistics, and is neither inherently good nor bad." -_Florinia Sevilla, Pokemon Reborn_

  "...I want you to be mine and not a lesson learned..." -_Janine Berdin, What if I miss you for the rest of my life?_

  "早い 早い 早い 早い 早い" -_Young Girl A_, Shiinamota
  
  "Mabubuhay akong nagsisisi kapag 'sang araw hindi kita mapangiti" -_Kalapastangan_, fitterkarma

  "At 'pag inuod na ang puso at utak, ang makikita nila'y ikaw" -_kahel na langit_, Maki

  "Puwede bang isipin mo kung bakit tayo nagsimula?" -_Pahina_, Cup of Joe


  "Why does everything have to be perfect? You know, perfection itself is imperfection." -_Vladimir Horowitz_

  "lagay mo sa cheatsheet" -_vynz_

  "i miss you so much" -_bibe 🦆_
  
  "bagay ba yung pink q sa purple mu" -_napakacute_
  ]
]
]