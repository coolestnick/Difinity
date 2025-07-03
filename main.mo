import Time "mo:base/Time";
import Text "mo:base/Text";
import Result "mo:base/Result";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Nat "mo:base/Nat";

actor LLMCanister {
    
    type WeatherData = {
        location: Text;
        temperature: Float;
        description: Text;
        timestamp: Int;
    };
    
    type CalculationResult = {
        operation: Text;
        result: Float;
        timestamp: Int;
    };
    
    private stable var requestCount: Nat = 0;
    
    // Tool function: Get weather information
    private func getWeather(location: Text) : async WeatherData {
        // Simulate weather API call
        let mockWeather: WeatherData = {
            location = location;
            temperature = 22.5;
            description = "Sunny with few clouds";
            timestamp = Time.now();
        };
        mockWeather
    };
    
    // Tool function: Perform calculations
    private func calculate(operation: Text, a: Float, b: Float) : async CalculationResult {
        let result = switch (operation) {
            case ("add") { a + b };
            case ("subtract") { a - b };
            case ("multiply") { a * b };
            case ("divide") { 
                if (b == 0.0) { 0.0 } else { a / b }
            };
            case (_) { 0.0 };
        };
        
        {
            operation = operation # "(" # Float.toText(a) # ", " # Float.toText(b) # ")";
            result = result;
            timestamp = Time.now();
        }
    };
    
    // Tool function: Get current timestamp
    private func getCurrentTime() : async Int {
        Time.now()
    };
    
    // Main chat function with tools - simulated LLM interaction
    public func chatWithTools(userMessage: Text) : async Result.Result<Text, Text> {
        try {
            requestCount += 1;
            
            // Simple tool detection based on keywords
            if (Text.contains(userMessage, #text "weather")) {
                // Extract location from message (simplified)
                let location = if (Text.contains(userMessage, #text "New York")) {
                    "New York"
                } else if (Text.contains(userMessage, #text "London")) {
                    "London"
                } else if (Text.contains(userMessage, #text "Tokyo")) {
                    "Tokyo"
                } else {
                    "Default City"
                };
                
                let weatherData = await getWeather(location);
                let response = "The weather in " # weatherData.location # 
                    " is " # Float.toText(weatherData.temperature) # "°C with " # 
                    weatherData.description # ".";
                #ok(response)
            } 
            else if (Text.contains(userMessage, #text "calculate") or Text.contains(userMessage, #text "add") or Text.contains(userMessage, #text "multiply")) {
                // Simple calculation parsing
                let result = await calculate("add", 10.0, 5.0);
                let response = "Calculation result: " # result.operation # " = " # Float.toText(result.result);
                #ok(response)
            }
            else if (Text.contains(userMessage, #text "time")) {
                let currentTime = await getCurrentTime();
                let response = "Current timestamp: " # Int.toText(currentTime);
                #ok(response)
            }
            else {
                // Default response
                let response = "Hello! I'm an LLM canister. You can ask me about weather, calculations, or the current time. Your message was: " # userMessage;
                #ok(response)
            }
        } catch (_) {
            #err("Error processing request")
        }
    };
    
    // Simple chat without tools
    public func simpleChat(userMessage: Text) : async Result.Result<Text, Text> {
        try {
            requestCount += 1;
            
            let response = "You said: " # userMessage # ". This is a simple response from the LLM canister.";
            #ok(response)
        } catch (_) {
            #err("Error processing request")
        }
    };
    
    // Get canister statistics
    public query func getStats() : async {requestCount: Nat; timestamp: Int} {
        {
            requestCount = requestCount;
            timestamp = Time.now();
        }
    };
    
    // Health check
    public query func health() : async Text {
        "LLM Canister is running. Total requests: " # Nat.toText(requestCount)
    };
}