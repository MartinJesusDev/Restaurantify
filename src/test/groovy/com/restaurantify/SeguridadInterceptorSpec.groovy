package com.restaurantify

import grails.testing.web.interceptor.InterceptorUnitTest
import spock.lang.Specification

class SeguridadInterceptorSpec extends Specification implements InterceptorUnitTest<SeguridadInterceptor> {

    def setup() {
    }

    def cleanup() {

    }

    void "Test seguridad interceptor matching"() {
        when:"A request matches the interceptor"
            withRequest(controller:"seguridad")

        then:"The interceptor does match"
            interceptor.doesMatch()
    }
}
