/**
 * Small shim to allow mocking out properties of window that don't have a function accessor.
 */
export class WindowShim {

    document(): Document {
        return window.document;
    }

    location(): Location {
        return window.location;
    }

    navigator(): Navigator {
        return window.navigator;
    }


}