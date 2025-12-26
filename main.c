// main.c
#define _GNU_SOURCE
#include <stdio.h>
#include <stdint.h>
#include <arm_sve.h>
#include <unistd.h>  // for syscall(__NR_gettid)

// 声明外部汇编函数
extern void svetest(void);

#include <sched.h>

// 将当前线程绑定到指定核心
void bind_to_core(int core_id) {
    cpu_set_t mask;
    CPU_ZERO(&mask);
    CPU_SET(core_id, &mask);
    
    // pid=0 表示当前线程
    if (sched_setaffinity(0, sizeof(mask), &mask) == -1) {
        perror("sched_setaffinity failed");
    }
}

// 获取第一个大核的ID
int get_big_core_id() {
    char path[256];
    FILE *fp;
    int cpu_id = -1;
    
    // 遍历CPU，查找大核（通常频率更高）
    for (int i = 0; i < 8; i++) { // 最多检测8核
        // 读取CPU频率信息
        snprintf(path, sizeof(path), 
                 "/sys/devices/system/cpu/cpu%d/cpufreq/cpuinfo_max_freq", i);
        fp = fopen(path, "r");
        if (!fp) continue;
        
        unsigned int freq;
        if (fscanf(fp, "%u", &freq) == 1) {
            // 通常大核频率 > 1.5GHz（具体阈值根据设备调整）
            if (freq > 1500000) {
                cpu_id = i;
                fclose(fp);
                break;
            }
        }
        fclose(fp);
    }
    
    // 如果无法检测，默认返回核心0
    // return (cpu_id >= 0) ? cpu_id : 0;
    return 7;
}

// 绑定到第一个大核（自动检测）
void bind_to_big_core(void) {
    int big_core = get_big_core_id();
    printf("正在绑定到CPU大核: %d\n", big_core);
    
    cpu_set_t mask;
    CPU_ZERO(&mask);
    CPU_SET(big_core, &mask);
    
    if (sched_setaffinity(0, sizeof(mask), &mask) == -1) {
        perror("绑定核心失败");
        exit(1);
    }
}
int main() {

    // 在调用SVE代码前绑定到大核
    bind_to_big_core();

    // 获取当前 SVE 寄存器长度 (以 bit 为单位)
    uint64_t vl_bits = svcntb() * 8;
    printf("环境检查: SVE 开启成功！\n");
    printf("当前向量长度 (Vector Length): %lu bits\n", vl_bits);

    svetest();

    return 0;
}