package re1kur.balanceservice.service.impl;

import dto.BalanceDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import re1kur.balanceservice.entity.Balance;
import exception.NoSubjectClaimException;
import exception.UserNotFoundException;
import re1kur.balanceservice.repository.BalanceRepository;
import re1kur.balanceservice.service.BalanceService;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class DefaultBalanceService implements BalanceService {
    private final BalanceRepository repo;

    @Override
    public BalanceDto getBalance(String userId) throws NoSubjectClaimException, UserNotFoundException {
        if (userId == null || userId.isEmpty()) throw new NoSubjectClaimException("No user ID found");
        Balance balance = repo.findById(UUID.fromString(userId)).orElseThrow(() -> new UserNotFoundException("User not found"));
        return new BalanceDto(balance.getUserId().toString(), balance.getBalance());
    }
}