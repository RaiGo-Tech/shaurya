import { Body, Controller, Param, Patch, Post } from '@nestjs/common';
import { IsIn, IsInt, IsString, IsUUID, Min } from 'class-validator';
import { AttemptsService } from './attempts.service';

class SaveAnswerDto { @IsUUID() questionId!: string; @IsInt() @Min(0) selectedOptionIndex!: number; @IsString() idempotencyKey!: string; }
class SubmitAttemptDto { @IsString() idempotencyKey!: string; }

@Controller('attempts')
export class AttemptsController {
  constructor(private readonly attempts: AttemptsService) {}
  @Post(':testId/start') start(@Param('testId') testId: string) { return this.attempts.start(testId); }
  @Patch(':attemptId/answers') save(@Param('attemptId') attemptId: string, @Body() dto: SaveAnswerDto) { return this.attempts.saveAnswer(attemptId, dto); }
  @Post(':attemptId/submit') submit(@Param('attemptId') attemptId: string, @Body() dto: SubmitAttemptDto) { return this.attempts.submit(attemptId, dto.idempotencyKey); }
}
