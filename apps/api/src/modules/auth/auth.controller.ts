import { Controller, Post, Body, Get, UseGuards } from '@nestjs/common';
import { ApiTags, ApiBearerAuth, ApiOperation } from '@nestjs/swagger';
import { AuthService } from './auth.service';
import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard';
import { CurrentUser } from '../../common/decorators/current-user.decorator';
import { LoginDto } from './dto';

@ApiTags('认证')
@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  @Post('login')
  @ApiOperation({ summary: '用户登录' })
  async login(@Body() dto: LoginDto) {
    return this.authService.login(dto.username, dto.password);
  }

  @Post('refresh')
  @ApiOperation({ summary: '刷新 Token' })
  async refresh(@Body('refreshToken') refreshToken: string) {
    // 简化实现：直接解析 refreshToken 获取 userId
    // 生产环境应使用 Redis 存储 refreshToken 白名单
    const payload = JSON.parse(
      Buffer.from(refreshToken.split('.')[1], 'base64').toString(),
    );
    return this.authService.refresh(payload.sub);
  }

  @Post('logout')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: '退出登录' })
  async logout() {
    return { message: '退出成功' };
  }

  @Get('me')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: '获取当前用户信息' })
  async me(@CurrentUser() user: any) {
    return user;
  }
}
