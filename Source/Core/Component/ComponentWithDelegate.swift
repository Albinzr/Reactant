//
//  ComponentWithDelegate.swift
//  Reactant
//
//  Created by Filip Dolnik on 09.11.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import RxSwift

public struct ActionMapper<ACTION> {
    private let performAction: (ACTION) -> Void

    public init(performAction: @escaping (ACTION) -> Void) {
        self.performAction = performAction
    }

    public func map<C: Component>(from component: C, using mapping: @escaping (C.ActionType) -> ACTION) -> ObservationToken {
        return component.observeAction { [performAction] action in
            performAction(mapping(action))
        }
    }
}

public protocol ComponentWithDelegate: Component {
    var componentDelegate: ComponentDelegate<StateType, ActionType> { get }

    #if ENABLE_RXSWIFT
    /**
     * Array of observables through which the Component communicates with outside world.
     * - ATTENTION: Each of the `Observable`s need to be *rewritten* or *mapped* to be of the correct type - the ACTION.
     * - `ObservableConvertibleType.rewrite` is used on the Observable if it's `Void` and `ObservableConvertibleType.map` if it carries a value
     * - a good idea is to create an `enum`, cases without value should be used with method
     *  `ObservableConvertibleType.rewrite` and cases with should be used with method `ObservableConvertibleType.map`
     * ## Example
     * ```
     * button.rx.tap.rewrite(with: MyRootViewAction.loginTapped)
     *
     * textField.rx.text.skip(1).map(MyRootViewAction.emailChanged)
     * ```
     *
     * For more info, see [Component Action](https://docs.reactant.tech/getting-started/quickstart.html#component-action)
     * - WARNING: When listening to Component's actions, subscribe to `Component.action` instead of this variable.
     *  `Component.action` includes `Component.perform(action:)` calls as well as `Observable`s defined in `actions`.
     */
    var actions: [Observable<ActionType>] { get }

    /**
     * Used to reset `actions` `Observable` array. Useful when you have a condition in `actions` based on which certain `Observable`s are included in the array.
     * ## Example
     * You decide to change the amount of active buttons based on device orientation. `actions` don't automatically change
     * based on the conditions that are in the computed variable, because this would be ineffective.
     * This is where you call `resetActions()` when orientation changes causing `actions` to update and the amount of active buttons is changed as well.
     */
    func resetActions()
    #elseif ENABLE_PROMISEKIT

    #endif
    func actionMapping(mapper: ActionMapper<ActionType>) -> Set<ObservationToken>

    /**
     * Used to reset `actions` `Observable` array. Useful when you have a condition in `actions` based on which certain `Observable`s are included in the array.
     * ## Example
     * You decide to change the amount of active buttons based on device orientation. `actions` don't automatically change
     * based on the conditions that are in the computed variable, because this would be ineffective.
     * This is where you call `resetActions()` when orientation changes causing `actions` to update and the amount of active buttons is changed as well.
     */
    func resetActionMapping()
}

private var componentDelegateKey = 0 as UInt8
extension ComponentWithDelegate {
    public var componentDelegate: ComponentDelegate<StateType, ActionType> {
        return associatedObject(self, key: &componentDelegateKey) {
            return ComponentDelegate(owner: self)
        }
    }
}

extension ComponentWithDelegate {
    public var previousComponentState: StateType? {
        return componentDelegate.previousComponentState
    }

    public var componentState: StateType {
        get {
            return componentDelegate.componentState
        }
        set {
            componentDelegate.componentState = newValue
        }
    }

    public func invalidate() {
        if componentDelegate.hasComponentState {
            componentDelegate.needsUpdate = true
        }
    }

    public func perform(action: ActionType) {
        componentDelegate.perform(action: action)
    }
}

#if ENABLE_RXSWIFT
extension ComponentWithDelegate {

    public var action: Observable<ActionType> {
        return componentDelegate.rxBehavior.action
    }
    
    public var stateDisposeBag: DisposeBag {
        return componentDelegate.rxBehavior.stateDisposeBag
    }

    public var observableState: Observable<StateType> {
        return componentDelegate.rxBehavior.observableState
    }

    public func observeState(_ when: ObservableStateEvent) -> Observable<StateType> {
        return componentDelegate.rxBehavior.observeState(when)
    }

    public func resetActions() {
        componentDelegate.rxBehavior.actions = actions
    }
}
#endif
extension ComponentWithDelegate {

    public var stateTracking: ObservationTokenTracker {
        return componentDelegate.behavior.stateTracking
    }

    public func actionMapping(mapper: ActionMapper<ActionType>) -> Set<ObservationToken> {
        return []
    }

    public func resetActionMapping() {
        componentDelegate.behavior.registerActionMapping(actionMapping)
    }

    public func observeAction(observer: @escaping (ActionType) -> Void) -> ObservationToken {
        return componentDelegate.behavior.observeAction(observer: observer)
    }

    public func observeState(_ when: ObservableStateEvent, observer: @escaping (StateType) -> Void) -> ObservationToken {
        return componentDelegate.behavior.observeState(when, observer: observer)
    }

}
