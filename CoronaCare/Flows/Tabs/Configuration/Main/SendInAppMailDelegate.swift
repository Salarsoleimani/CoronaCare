//
//  SendInAppMailDelegate.swift
//  VirusCare
//
//  Created by Salar Soleimani on 2020-03-16.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import MessageUI

extension ConfigurationViewController: MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    controller.dismiss(animated: true)
  }
  
  func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
    controller.dismiss(animated: true)
  }
}
