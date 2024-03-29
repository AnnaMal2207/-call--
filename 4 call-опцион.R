# 4 Лабораторная работа: call-опцион
#1. Реализовать последовательность {𝐵𝑛} для заданного значения ставки 𝑟 = 0.01, 
#используя формулу (5), за период 𝑁 = 200 при 𝐵0 = 1. Построить график
B_0 = 1
N = 200
r = 0.01

S_0 = 1
a = -0.3
b = 0.8
p = 0.4
q = 1 - p

# Генерируем последовательность независимых случайных величин
ro <- sample(c(a, b), N, replace = TRUE, prob = c(q, p))
ro
r=rbinom(N,1,p)
r
r[r==1]<-b
r[r==0]<-a
r
# Вычисляем последовательности B_n и S_n
B_n = numeric(N);B_n 
S_n = numeric(N);S_n
B_n[1] = B_0
S_n[1] = S_0
for (i in 2:N) {B_n[i] = (1 + r) * B_n[i-1]
                S_n[i] = (1 + ro[i]) * S_n[i-1]
                }
plot(B_n,type="l",col="blue")
plot(S_n,type="l",col="violet")
plot(B_n, type="l", col="blue", ylim=c(0, max(B_n, S_n)))
lines(S_n, type="l", col="red")
legend("topleft", legend=c("Bn", "Sn"), col=c("blue", "red"), lty=1)

#3. Рассчитать справедливую цену 𝑐𝑎𝑙𝑙-опциона по формуле (7) при следующих значениях параметров: 
#𝑆0 = 100, 𝑁 = 10, 𝑎 = −0.3, 𝑏 = 0.8, 𝑟 = 0.2,𝐾 = 100.
S_0 = 100
N = 10
a = -0.3
b = 0.8
r = 0.2
K = 100

#значения K0, p* и p~
K_0 = 1 + ((log(K / (S_0*((1+a)^N)))) * ((log((1 + b)/(1 + a)))^(-1)))
K_0
p_1 = (1 + b) / (1 + r)
p_1
p_2 = (r - a) / (b - a)
p_2

#Значение B(K0, N; p*)
B_K0_N_p1 = 0
if (p_1 > 1) {p_1 = 1}
for (k in K_0:N) {B_K0_N_p1 = B_K0_N_p1 + dbinom(round(k), N, p_1)}
B_K0_N_p1

#Значение B(K0, N; p~)
B_K0_N_p_2 = 0
if (p_2 > 1) {p_2 = 1}
for (k in K_0:N) {B_K0_N_p_2 = B_K0_N_p_2 + dbinom(round(k), N, p_2)}
B_K0_N_p_2

# Рассчитываем справедливую цену опциона
if (K_0 <= N) {C_N = S_0 * B_K0_N_p1 - K * ((1 + r)^(-N)) * B_K0_N_p_2} else {C_N = 0}

print(C_N)
