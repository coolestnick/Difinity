# LLM Canister for Internet Computer

A Motoko canister that demonstrates LLM integration with tools functionality on the Internet Computer Protocol (ICP).

## Features

- **Tool Integration**: Simulated LLM tool calling with weather, calculations, and time functions
- **Chat Interface**: Two modes - simple chat and chat with tools
- **Weather Tool**: Get weather information for specified locations
- **Calculator Tool**: Perform basic mathematical operations
- **Time Tool**: Get current timestamp
- **Request Tracking**: Monitor canister usage with statistics

## API Functions

### `chatWithTools(userMessage: Text) : async Result<Text, Text>`
Processes user messages with tool detection and execution. Supports:
- Weather queries (mention "weather" and location)
- Calculations (mention "calculate", "add", "multiply")
- Time queries (mention "time")

### `simpleChat(userMessage: Text) : async Result<Text, Text>`
Basic chat functionality without tool integration.

### `getStats() : async {requestCount: Nat; timestamp: Int}`
Returns canister statistics including request count and current timestamp.

### `health() : async Text`
Health check endpoint returning canister status.

## Tool Functions

### Weather Tool
- **Function**: `getWeather(location: Text)`
- **Returns**: WeatherData with location, temperature, description, and timestamp
- **Example**: "What's the weather in New York?"

### Calculator Tool
- **Function**: `calculate(operation: Text, a: Float, b: Float)`
- **Operations**: add, subtract, multiply, divide
- **Returns**: CalculationResult with operation details and result
- **Example**: "Calculate 10 + 5"

### Time Tool
- **Function**: `getCurrentTime()`
- **Returns**: Current timestamp as Int
- **Example**: "What's the current time?"

## Deployment

1. Install DFX (Internet Computer SDK)
2. Start local replica: `dfx start`
3. Deploy canister: `dfx deploy`
4. Interact with canister: `dfx canister call llm_canister chatWithTools '("What is the weather in Tokyo?")'`

## Example Usage

```bash
# Chat with tools
dfx canister call llm_canister chatWithTools '("What is the weather in London?")'

# Simple chat
dfx canister call llm_canister simpleChat '("Hello, how are you?")'

# Get statistics
dfx canister call llm_canister getStats

# Health check
dfx canister call llm_canister health
```

## Architecture

The canister demonstrates the tool calling pattern where:
1. User input is analyzed for tool requirements
2. Appropriate tools are called with extracted parameters
3. Tool results are processed and formatted
4. Final response is returned to the user

This implementation provides a foundation for building more sophisticated LLM integrations on the Internet Computer.