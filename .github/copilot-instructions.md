# Copilot Instructions

## Project Context
- This is a Flutter mobile app focused on health and fitness called "MoveOn"
- The app integrates with iOS HealthKit for workout tracking
- Primary language is Portuguese (pt-br)

## Architecture & Patterns
- The project follows a MVVM architecture pattern
- Uses auto_injector for dependency injection
- Implements auto_route for navigation
- Uses ListenableBuilder for state management

## Code Style & Standards
- Follow Flutter/Dart style guidelines
- Use CupertinoStyle widgets for iOS-like interface
- Implement error handling with proper user feedback
- Use const constructors when possible
- Theme customization through FTheme

## Testing

### Test Structure

- Tests mirror the lib folder structure:
  - test/data/repositories/ for repository tests
  - test/data/services/ for service tests
  - test/ui/{feature}/ for widget tests
  - test/mocks/ for shared test mocks and fakes

### Test Patterns

- Use mocktail for mocking dependencies
  - Mocks are defined in test/mocks/mocks.dart
  - Fakes are defined in test/mocks/fakes.dart
- Tests follow the AAA pattern (Arrange, Act, Assert)
- Group tests logically using group() blocks
- Use descriptive test names that explain the scenario

### Widget Testing

- Use testApp() helper from test/app.dart for consistent widget testing setup
- Test UI interactions using WidgetTester
- Verify widget states and user interactions
- Mock dependencies using DI configuration

### Repository Testing

- Test success and failure scenarios
- Verify integration with services
- Use Result type for error handling verification
- Mock platform-specific behavior when needed

### Service Testing

- Test platform-specific implementations
- Verify external service integrations (e.g., HealthKit)
- Handle both success and error cases
- Mock external dependencies

### Test Best Practices
- Keep tests focused and isolated
- Use setUp and tearDown for common test setup
- Verify error messages are in Portuguese
- Test error handling and edge cases
- Use proper error handling with Result type

## File Structure

### UI Layer

- UI components in lib/ui/ directory
- Screen widgets in lib/ui/{feature}/widgets/
- View models follow MVVM pattern in lib/ui/{feature}/view_models/
- The UI layer should only interact with repositories or view models
- Use auto_route for navigation

### Domain Layer (lib/domain/)

- Entities in lib/domain/entities/
  - Pure Dart classes representing core business objects
  - Use dart_mappable for serialization
  - Follow immutable pattern with copyWith support

### Data Layer (lib/data/)

- Repositories in lib/data/repositories/{feature}/
  - Implementation of domain interfaces
  - Handle data persistence and API calls
  - Follow repository pattern with interfaces and implementations
  - The UI layer should only interact with repositories or view models
- Services in lib/data/services/{feature}/
  - Platform-specific implementations (e.g., HealthKit)
  - External service integrations
  - Every service should have an interface and the name of the implementation of a service should be suffixed with "\_impl.dart"

### Dependency Injection

- Configuration in lib/di/dependency_injection.dart
- Single source of DI using auto_injector

### Utils and Core

- Common utilities in lib/utils/
- Shared extensions in lib/extensions/
- Core app configuration in lib/core/
- Navigation configuration in lib/routing/router.dart
  - Use auto_route for navigation
  - Define routes and route guards

## Dependencies & Tools
- Uses dio for HTTP requests
- Implements dio_cache_interceptor for caching
- Uses health package for HealthKit integration
- Cached network image handling with cached_network_image
- Local storage with shared_preferences
- Permission handling with permission_handler

## Assets & Resources

- Store images in assets/ directory
- Launch screen assets in iOS specific directories
- Follow proper asset naming conventions

## Platform Specific
- iOS deployment target is 13.0
- Requires HealthKit permissions
- Handle background modes for fetch and notifications
- Support dark/light mode through FTheme

## Documentation

- Add descriptive comments for complex logic
- Document public APIs and classes
- Include usage examples for shared components
- Write clear error messages in Portuguese

## Error Handling
- Display user-friendly error messages in Portuguese
- Implement proper error states in UI
- Use Result type for error handling
- Log errors appropriately for debugging
