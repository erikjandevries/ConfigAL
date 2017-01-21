import matplotlib
print("")
print(matplotlib.rcsetup.all_backends)
print("")
# matplotlib.use('GTK3Agg')
import matplotlib.pyplot as plt
side = [0,1,2,3,4]
area = [0,1,4,9,16]
plt.plot(side,area)
plt.show()
