import { ConflictException, Injectable } from '@nestjs/common';

@Injectable()
export class AttemptsService {
  // Replace this thin contract shell with Prisma transactions + BullMQ jobs.
  // Attempt finalization is idempotent; evaluation/ranking never run in HTTP.
  private readonly finalizedKeys = new Set<string>();
  start(testId: string) { return { success: true, data: { testId, attemptId: crypto.randomUUID(), serverStartedAt: new Date().toISOString(), status: 'IN_PROGRESS' }, message: 'Attempt started' }; }
  saveAnswer(attemptId: string, answer: unknown) { return { success: true, data: { attemptId, answer, syncStatus: 'SYNCED' }, message: 'Answer saved' }; }
  submit(attemptId: string, key: string) {
    if (this.finalizedKeys.has(key)) throw new ConflictException({ success: false, error: { code: 'DUPLICATE_SUBMISSION', message: 'This attempt is already finalized.' } });
    this.finalizedKeys.add(key);
    return { success: true, data: { attemptId, status: 'PROCESSING' }, message: 'Attempt finalized; evaluation queued.' };
  }
}
