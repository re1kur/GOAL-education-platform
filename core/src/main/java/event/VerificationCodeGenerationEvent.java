package event;

public record VerificationCodeGenerationEvent(String email, String code) {
}
