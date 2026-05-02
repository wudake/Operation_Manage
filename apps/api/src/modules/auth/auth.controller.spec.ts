import { Test, TestingModule } from '@nestjs/testing';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';
import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard';

describe('AuthController', () => {
  let controller: AuthController;
  let authService: jest.Mocked<Partial<AuthService>>;

  beforeEach(async () => {
    authService = {
      login: jest.fn().mockResolvedValue({
        accessToken: 'token',
        refreshToken: 'refresh',
        user: { id: '1', username: 'admin', realName: '管理员', role: 'SUPER_ADMIN', avatar: null },
      }),
      refresh: jest.fn().mockResolvedValue({ accessToken: 'new-token' }),
    };

    const module: TestingModule = await Test.createTestingModule({
      controllers: [AuthController],
      providers: [{ provide: AuthService, useValue: authService }],
    })
      .overrideGuard(JwtAuthGuard)
      .useValue({ canActivate: () => true })
      .compile();

    controller = module.get<AuthController>(AuthController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  describe('login', () => {
    it('should call authService.login with credentials', async () => {
      const dto = { username: 'admin', password: 'admin123' };
      const result = await controller.login(dto);

      expect(authService.login).toHaveBeenCalledWith('admin', 'admin123');
      expect(result).toEqual(expect.objectContaining({ accessToken: 'token' }));
    });
  });

  describe('refresh', () => {
    it('should call authService.refresh with userId from token payload', async () => {
      const refreshToken = 'header.eyJzdWIiOiJ1c2VyLTEifQ.signature';
      const result = await controller.refresh(refreshToken);

      expect(authService.refresh).toHaveBeenCalledWith('user-1');
      expect(result).toEqual({ accessToken: 'new-token' });
    });
  });

  describe('logout', () => {
    it('should return success message', async () => {
      const result = await controller.logout();
      expect(result).toEqual({ message: '退出成功' });
    });
  });

  describe('me', () => {
    it('should return current user', async () => {
      const user = { sub: '1', username: 'admin' };
      const result = await controller.me(user as any);
      expect(result).toEqual(user);
    });
  });
});
