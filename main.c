// main.c
#include <stdio.h>
#include <stdint.h>

// 声明外部汇编函数
extern void smtest(void);

int main() {

    smtest();

    return 0;
}