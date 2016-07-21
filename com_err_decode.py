import win32api
e_msg = win32api.FormatMessage(-2147352571)
print e_msg
#print e_msg.decode('CP1251')
