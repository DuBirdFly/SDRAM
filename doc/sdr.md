# sdr

## 管脚

也就是 [MT48LC16M16A2TG-75ITD (P14)](doc/spec/MT48LC16M16A2TG-75ITD.PDF)

### 时钟信号

CLK: 上升沿采样; 递增内部突发计数器并控制输出寄存器。
CKE: 是为低功耗设计的, 但一般恒接 1; 低电平时有以下效果:

    - precharge power-down and SELF-REFRESH operation (all banks idle)
    - active power-down (row active in any bank)
    - LOCK SUSPEND operation (burst/access in pro-gress)
    (注: CKE 是一般是同步的, 除非设备在 power-down 或者 self-refresh 模式下)

### 命令信号

CS_N: 片选信号; 控制指令译码 (决定该 command 是否有效), 不影响 dqm, 且已经在运行的突发不会被停止
    (注: 通常也被认为是 command 命令的一部分)
CAS_N, RAS_N, WE_N: 定义 command 命令

### 地址信号

A: ADDR 地址线, 不同的 command 下的含义不同

    - ACTIVE 命令: 行地址
    - READ/WRITE 命令: 列地址 (A10 用于 "自动预充电")
    - PRECHARGE 命令: 所有 bank 都预充电 (A10 == 1); 单个 bank 预充电 (A10 == 0, BA 用于选择 bank)

BA: Bank Address, 用于决定哪个 bank 会执行 ACTIVE, READ/WRITE, PRECHARGE 命令

### 数据信号

DQ: Data Input/Output, inout 信号
DQM: Data Mask, 0: 不进行掩码, 1: 进行掩码; 只在读/写周期内有效

## 命令






## 电气特性与推荐的AC参数

也就是 [MT48LC16M16A2TG-75ITD (P27)](doc/spec/MT48LC16M16A2TG-75ITD.PDF)
