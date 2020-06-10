//
//  KernelConnector.h
//  itlwm-client
//
//  Created by gimdh on 2020/06/10.
//  Copyright © 2020 gimdh. All rights reserved.
//

#ifndef KernelConnector_h
#define KernelConnector_h

#define CONTROL_NAME "ITLWM"


#define COM_JOIN 1

struct connection_data {
    char ssid[256];
    char passwd[256];
};

int open_socket(void);
int send_join_ssid(const char *ssid, const char *passwd);
int send_command(int id, const void *data, int data_len);
int close_socket(void);

#endif /* KernelConnector_h */
