import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { ThrottlerModule } from '@nestjs/throttler';
import { AttemptsController } from './modules/attempts/attempts.controller';
import { AttemptsService } from './modules/attempts/attempts.service';
import { HealthController } from './health.controller';

@Module({
  imports: [ConfigModule.forRoot({ isGlobal: true }), ThrottlerModule.forRoot([{ ttl: 60000, limit: 120 }])],
  controllers: [HealthController, AttemptsController],
  providers: [AttemptsService],
})
export class AppModule {}
