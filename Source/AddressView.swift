import Foundation
import UIKit

/// Address View displaying a form to enter address information.
public class AddressView: UIView {

    // MARK: - Properties
    let phoneNumberKit = PhoneNumberKit()

    let scrollView = UIScrollView()
    let contentView = UIView()
    let stackView = UIStackView()

    let nameInputView = StandardInputView()
    let addressLine1InputView = StandardInputView()
    let addressLine2InputView = StandardInputView()
    let cityInputView = StandardInputView()
    let stateInputView = StandardInputView()
    let zipInputView = StandardInputView()
    let phoneInputView = PhoneNumberInputView()
    let countryRegionInputView = DetailsInputView()

    let countrySelectionViewController = CountrySelectionViewController()
    let countryRegionTapGesture = UITapGestureRecognizer()

    let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done,
                                     target: self, action: nil)
    var scrollViewBottomConstraint: NSLayoutConstraint!
    var notificationCenter: NotificationCenter = NotificationCenter.default
    var regionCodeSelected: String?

    // MARK: - Initialization

    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    /// Returns an object initialized from data in a given unarchiver.
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        backgroundColor = UIColor.groupTableViewBackground
        stackView.axis = .vertical
        stackView.spacing = 16
        addViews()
        addInitialConstraints()
        nameInputView.set(label: "name", backgroundColor: .white)
        countryRegionInputView.set(label: "countryRegion", backgroundColor: .white)
        addressLine1InputView.set(label: "addressLine1", backgroundColor: .white)
        addressLine2InputView.set(label: "addressLine2", backgroundColor: .white)
        cityInputView.set(label: "postalTown", backgroundColor: .white)
        stateInputView.set(label: "state", backgroundColor: .white)
        zipInputView.set(label: "postcode", backgroundColor: .white)
        phoneInputView.set(label: "phone", backgroundColor: .white)
        // set content type
        nameInputView.textField.textContentType = .name
        addressLine1InputView.textField.textContentType = .streetAddressLine1
        addressLine2InputView.textField.textContentType = .streetAddressLine2
        cityInputView.textField.textContentType = .addressCity
        stateInputView.textField.textContentType = UITextContentType.addressState
        zipInputView.textField.textContentType = .postalCode
        // set keyboard
//        phoneInputView.textField.keyboardType = .phonePad

        addKeyboardToolbarNavigation(textFields: [
            nameInputView.textField,
            addressLine1InputView.textField,
            addressLine2InputView.textField,
            cityInputView.textField,
            stateInputView.textField,
            zipInputView.textField,
            phoneInputView.textField
            ])
    }

    private func addViews() {
        stackView.addArrangedSubview(nameInputView)
        stackView.addArrangedSubview(countryRegionInputView)
        stackView.addArrangedSubview(addressLine1InputView)
        stackView.addArrangedSubview(addressLine2InputView)
        stackView.addArrangedSubview(cityInputView)
        stackView.addArrangedSubview(stateInputView)
        stackView.addArrangedSubview(zipInputView)
        stackView.addArrangedSubview(phoneInputView)
        contentView.addSubview(stackView)
        scrollView.addSubview(contentView)
        addSubview(scrollView)
    }

    private func addInitialConstraints() {
        scrollViewBottomConstraint = self.addScrollViewContraints(scrollView: scrollView, contentView: contentView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false

        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.safeTopAnchor, constant: 16).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.safeBottomAnchor).isActive = true
    }

}
