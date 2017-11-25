package com.ftpix.sss.automation.framework.common;

import com.ftpix.sss.automation.utils.ElementImpl;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.List;

public class Switcher extends ElementImpl {

    private static final By BUTTONS = By.cssSelector(".item");

    public Switcher(WebElement element) {
        super(element);
    }

    public List<WebElement> getButtons() {
        return findElements(BUTTONS);
    }
}
